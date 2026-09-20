import '../units/gki.dart';
import '../units/glucose.dart';

/// Ölçüm türü: glukoz veya KAN ketonu (BHB). İdrar/nefes ketonu bu motora
/// girmez; ayrı eğitim kaydıdır (MASTER_PROMPT §6.1).
enum MeasurementKind { glucose, ketone }

/// Eşleştirme adayı: motora giren ölçümün asgari temsili.
class MeasurementCandidate {
  const MeasurementCandidate({
    required this.id,
    required this.kind,
    required this.atUtc,
    this.usedInSessionId,
  });

  final int id;
  final MeasurementKind kind;
  final DateTime atUtc;

  /// Bu ölçüm başka bir oturumda kullanıldıysa oturum kimliği; kullanılmış
  /// ölçüm ikinci bir oturuma önerilmez (MASTER §6.3).
  final int? usedInSessionId;

  bool get isUsed => usedInSessionId != null;
}

/// Eşleştirme önerisi sonucu.
class PairSuggestion {
  const PairSuggestion({
    required this.glucose,
    required this.ketone,
    required this.differenceMinutes,
  });

  final MeasurementCandidate glucose;
  final MeasurementCandidate ketone;

  /// Mutlak zaman farkı (dakika) — grafikte 'yaklaşık eşleşme' bilgisi.
  final int differenceMinutes;
}

/// Deterministik eşleştirme motoru (MASTER_PROMPT §6.3):
/// - pencere: varsayılan ±5 dk (ayar 1–15);
/// - en küçük |Δt|; eşitlikte DAHA ERKEN zaman damgası;
/// - başka oturumda kullanılmış ölçüm önerilmez;
/// - pencere dışı eşleşme otomatik yapılmaz → null döner.
abstract final class MatchingEngine {
  static const int defaultWindowMinutes = 5;
  static const int minWindowMinutes = 1;
  static const int maxWindowMinutes = 15;

  /// [glucoses] ve [ketones] arasından en iyi çifti önerir ya da null.
  ///
  /// Saf fonksiyon: girdi listeleri değiştirilmez.
  static PairSuggestion? suggestPair({
    required List<MeasurementCandidate> glucoses,
    required List<MeasurementCandidate> ketones,
    int windowMinutes = defaultWindowMinutes,
  }) {
    final window = windowMinutes.clamp(minWindowMinutes, maxWindowMinutes);
    PairSuggestion? best;
    for (final g in glucoses) {
      if (g.kind != MeasurementKind.glucose || g.isUsed) continue;
      for (final k in ketones) {
        if (k.kind != MeasurementKind.ketone || k.isUsed) continue;
        final diff = k.atUtc.difference(g.atUtc).inMinutes;
        final abs = diff.abs();
        if (abs > window) continue;
        final better = best == null || _preferable(g, k, abs, best);
        if (better) {
          best = PairSuggestion(glucose: g, ketone: k, differenceMinutes: abs);
        }
      }
    }
    return best;
  }

  /// [best] ile yeni adayı karşılaştırır: küçük |Δt| kazanır; eşitlikte
  /// daha erken glukoz zaman damgası kazanır.
  static bool _preferable(
    MeasurementCandidate g,
    MeasurementCandidate k,
    int abs,
    PairSuggestion best,
  ) {
    if (abs != best.differenceMinutes) return abs < best.differenceMinutes;
    return g.atUtc.isBefore(best.glucose.atUtc);
  }

  /// Aynı anda girilen glukoz + BHB'den 'eşzamanlı' oturum hesabı yapar.
  /// Onay kullanıcıya aittir; bu fonksiyon yalnızca hesabı üretir.
  static GkiResult simultaneousSession({
    required GlucoseValue glucose,
    required double bhbMmolL,
  }) => GkiEngine.fromRaw(glucose: glucose, bhbMmolL: bhbMmolL);

  /// Ayrı girişlerin onaylanmış eşleşmesinden 'yaklaşık eşleşme' oturumu.
  static GkiResult approximateMatch({
    required GlucoseValue glucose,
    required double bhbMmolL,
  }) => GkiEngine.fromRaw(glucose: glucose, bhbMmolL: bhbMmolL);
}
