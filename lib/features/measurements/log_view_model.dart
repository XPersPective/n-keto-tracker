import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/database/providers.dart';

/// Günlük ekranı veri modeli: tek kronolojik çizelge girdileri
/// (MASTER_PROMPT §5.2). Öğünler T16'da, ağırlık T22'de, semptom T23'te
/// bu birleşime eklenir.
sealed class TimelineEntry {
  const TimelineEntry({required this.atUtc, required this.offsetMinutes});

  final DateTime atUtc;
  final int offsetMinutes;

  DateTime get local => atUtc.add(Duration(minutes: offsetMinutes));
}

class MeasurementTimelineEntry extends TimelineEntry {
  const MeasurementTimelineEntry({
    required super.atUtc,
    required super.offsetMinutes,
    required this.sessionId,
    required this.glucoseMmolL,
    required this.glucoseRaw,
    required this.glucoseUnit,
    required this.bhbMmolL,
    required this.gki,
    required this.isValid,
    required this.matchKind,
    this.matchDifferenceMinutes,
    this.relatedMealType,
    this.relatedMealHoursAfter,
  });

  final int sessionId;
  final double glucoseMmolL;
  final double glucoseRaw;
  final String glucoseUnit;
  final double bhbMmolL;
  final double gki;
  final bool isValid;
  final String matchKind; // simultaneous | approximate
  final int? matchDifferenceMinutes;

  /// En yakın önceki öğün (pencere içinde) — yalnızca zamansal bağlam
  /// (MASTER §8.3). Null ise pencerede öğün yok.
  final String? relatedMealType;
  final double? relatedMealHoursAfter;
}

class NoteTimelineEntry extends TimelineEntry {
  const NoteTimelineEntry({
    required super.atUtc,
    required super.offsetMinutes,
    required this.note,
  });

  final String note;
}

/// Grafik noktası: ham değer korunur, eksik gün sıfır SAYILMAZ — nokta
/// yoktur (MASTER_PROMPT §12).
class ChartPoint {
  const ChartPoint({required this.atUtc, required this.value});

  final DateTime atUtc;
  final double value;
}

/// Geçerli oturumları kronolojik girdilere çevirir (yeni → eski listede).
final timelineProvider = FutureProvider.autoDispose<List<TimelineEntry>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final rows =
      await (db.select(db.measurementSession)
            ..where((s) => s.isValid.equals(true))
            ..orderBy([(s) => OrderingTerm.desc(s.computedAtUtc)]))
          .get();
  final entries = <TimelineEntry>[];
  for (final s in rows) {
    if (s.glucoseId == null || s.ketoneId == null) continue;
    final g = await (db.select(
      db.glucoseMeasurement,
    )..where((t) => t.id.equals(s.glucoseId!))).getSingle();
    final k = await (db.select(
      db.ketoneMeasurement,
    )..where((t) => t.id.equals(s.ketoneId!))).getSingle();
    entries.add(
      MeasurementTimelineEntry(
        atUtc: g.measuredAtUtc,
        offsetMinutes: g.localOffsetMinutes,
        sessionId: s.id,
        glucoseMmolL: g.mmolL,
        glucoseRaw: g.rawValue,
        glucoseUnit: g.rawUnit,
        bhbMmolL: k.mmolL,
        gki: s.gkiValue,
        isValid: s.isValid,
        matchKind: s.matchKind,
        matchDifferenceMinutes: s.matchDifferenceMinutes,
      ),
    );
  }
  return entries;
});

/// Grafik serileri: GKI, glukoz (mmol/L), BHB — ayrı ayrı (§22.4).
class ChartSeries {
  const ChartSeries({
    required this.gki,
    required this.glucose,
    required this.bhb,
  });

  final List<ChartPoint> gki;
  final List<ChartPoint> glucose;
  final List<ChartPoint> bhb;
}

final chartSeriesProvider = FutureProvider.autoDispose<ChartSeries>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final sessions = await (db.select(
    db.measurementSession,
  )..where((s) => s.isValid.equals(true))).get();
  final gki = <ChartPoint>[];
  final glucose = <ChartPoint>[];
  final bhb = <ChartPoint>[];
  for (final s in sessions) {
    if (s.glucoseId == null || s.ketoneId == null) continue;
    final g = await (db.select(
      db.glucoseMeasurement,
    )..where((t) => t.id.equals(s.glucoseId!))).getSingle();
    final k = await (db.select(
      db.ketoneMeasurement,
    )..where((t) => t.id.equals(s.ketoneId!))).getSingle();
    gki.add(ChartPoint(atUtc: g.measuredAtUtc, value: s.gkiValue));
    glucose.add(ChartPoint(atUtc: g.measuredAtUtc, value: g.mmolL));
    bhb.add(ChartPoint(atUtc: k.measuredAtUtc, value: k.mmolL));
  }
  int byTime(ChartPoint a, ChartPoint b) => a.atUtc.compareTo(b.atUtc);
  gki.sort(byTime);
  glucose.sort(byTime);
  bhb.sort(byTime);
  return ChartSeries(gki: gki, glucose: glucose, bhb: bhb);
}, dependencies: [appDatabaseProvider]);

/// Ağırlık serisi (T24).
final weightSeriesProvider = FutureProvider.autoDispose<List<ChartPoint>>((
  ref,
) async {
  final db = ref.watch(appDatabaseProvider);
  final rows = await db.select(db.weightEntry).get();
  final points =
      rows.map((r) => ChartPoint(atUtc: r.measuredAtUtc, value: r.kg)).toList()
        ..sort((a, b) => a.atUtc.compareTo(b.atUtc));
  return points;
}, dependencies: [appDatabaseProvider]);

/// Araştırma bantları: varsayılan KAPALI (MASTER_PROMPT §6.4). Kullanıcı
/// kaynağı okuyup bilinçli açar; açıklama metni her durumda görünür.
class BandSettings extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

final researchBandsProvider = NotifierProvider<BandSettings, bool>(
  BandSettings.new,
);

/// Bant kalıcı açıklaması (MASTER_PROMPT §6.4 metni; testte doğrulanır).
String bandDisclaimer(AppLocalizations l10n) => l10n.bandsDisclaimer;
