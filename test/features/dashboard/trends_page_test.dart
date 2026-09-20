import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/dashboard/trends_page.dart';

/// T24 trendler ekranı testleri (MASTER_PROMPT §5.4 + §12): metinsel
/// özet (semantics), aralık değişimi, boş aralıkta dürüst durum,
/// "ne anlatır/ne anlatmaz" kalıcı açıklaması.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Future<void> insertSession(DateTime atUtc, double mmolL) async {
    final g = await db
        .into(db.glucoseMeasurement)
        .insert(
          GlucoseMeasurementCompanion.insert(
            rawValue: mmolL * 18,
            rawUnit: 'mg_dL',
            mmolL: mmolL,
            measuredAtUtc: atUtc,
            localOffsetMinutes: 180,
            sourceType: 'fingerstick',
          ),
        );
    final k = await db
        .into(db.ketoneMeasurement)
        .insert(
          KetoneMeasurementCompanion.insert(
            rawValue: 2.5,
            mmolL: 2.5,
            measuredAtUtc: atUtc,
            localOffsetMinutes: 180,
          ),
        );
    await db
        .into(db.measurementSession)
        .insert(
          MeasurementSessionCompanion.insert(
            glucoseId: Value(g),
            ketoneId: Value(k),
            gkiValue: mmolL / 2.5,
            formulaVersion: 'gki-v1',
            matchKind: 'simultaneous',
            confirmedByUser: true,
            computedAtUtc: atUtc,
          ),
        );
  }

  Widget scope() => ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: TrendsPage(),
    ),
  );

  testWidgets('boş aralıkta dürüst durum + kalıcı açıklama', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Veri yok: her grafik "bu aralıkta veri yok" der; çizgi uydurulmaz.
    expect(find.text('No data in this range.'), findsWidgets);
    // Kalıcı açıklama kıvrım altında — kaydırıp kur.
    final explains = find.textContaining('does not diagnose');
    await tester.scrollUntilVisible(
      explains,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(explains, findsOneWidget);
  });

  testWidgets('ölçüm eklendiğinde metinsel özet görünür (semantics kanıtı)', (
    tester,
  ) async {
    await insertSession(
      DateTime.now().toUtc().subtract(const Duration(days: 1)),
      5.0,
    );
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Metinsel özet: ekran okuyucu grafiğin yerine bunu okur.
    expect(find.textContaining('readings in the last'), findsWidgets);
    expect(find.textContaining('Latest:'), findsWidgets);
  });

  testWidgets('aralık değişimi: 90 güne geçiş daha eski noktayı getirir', (
    tester,
  ) async {
    await insertSession(
      DateTime.now().toUtc().subtract(const Duration(days: 60)),
      10.0,
    );
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // 7 gün seçiliyken 60 gün önceki nokta görünmez.
    expect(find.text('No data in this range.'), findsWidgets);
    // 90 güne geç.
    await tester.tap(find.text('90'));
    await tester.pumpAndSettle();
    expect(find.textContaining('readings in the last 90'), findsWidgets);
  });
}
