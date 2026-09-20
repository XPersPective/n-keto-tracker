import 'formula_version.dart';
import 'glucose.dart';

/// GKI hesap hataları (MASTER_PROMPT §2.4/§15).
sealed class GkiValidationError implements Exception {
  const GkiValidationError();

  @override
  String toString() => switch (this) {
    BhbNotPositive() => 'BHB_MUST_BE_POSITIVE',
  };
}

class BhbNotPositive extends GkiValidationError {
  const BhbNotPositive();
}

/// GKI hesap sonucu: değer + kullanılan formül sürümü + hesap adımları
/// (UI 'ayrıntıda ham hesap adımları' gösterir — MASTER §6.2).
class GkiResult {
  const GkiResult({
    required this.value,
    required this.glucoseMmolL,
    required this.bhbMmolL,
    required this.formulaVersion,
  });

  final double value;

  /// Hesapta kullanılan normalize girdiler (kanıt zinciri).
  final double glucoseMmolL;
  final double bhbMmolL;

  /// [formulaVersion] sabiti: hangi sürümle hesaplandı.
  final String formulaVersion;
}

/// Tek, saf ve sürümlenmiş GKI motoru (MASTER_PROMPT §2.4).
///
/// UI, grafik, export ve rapor YALNIZCA bu modülü kullanır; formülün başka
/// bir yerde tekrar yazılması test ile engellenir (grep testi).
abstract final class GkiEngine {
  /// GKI = glukoz mmol/L ÷ BHB mmol/L. BHB ≤ 0 → [BhbNotPositive]
  /// (bölme yapılmaz, sessiz clamp yok). Girdiler zaten normalize
  /// mmol/L'dir; ham glukoz için önce [GlucoseValue.fromRaw] kullanın.
  static GkiResult fromMmolL({
    required double glucoseMmolL,
    required double bhbMmolL,
  }) {
    _validateFinite(glucoseMmolL);
    _validateFinite(bhbMmolL);
    if (bhbMmolL <= 0) {
      throw const BhbNotPositive();
    }
    if (glucoseMmolL <= 0) {
      throw const GlucoseNotPositive();
    }
    return GkiResult(
      // Ara yuvarlama yok: doğrudan tam hassasiyetli bölüm.
      value: glucoseMmolL / bhbMmolL,
      glucoseMmolL: glucoseMmolL,
      bhbMmolL: bhbMmolL,
      formulaVersion: formulaVersion,
    );
  }

  /// Ham glukoz (mg/dL veya mmol/L) + kan BHB'den hesaplar.
  static GkiResult fromRaw({
    required GlucoseValue glucose,
    required double bhbMmolL,
  }) => fromMmolL(glucoseMmolL: glucose.mmolL, bhbMmolL: bhbMmolL);

  static void _validateFinite(double v) {
    if (v.isNaN || v.isInfinite) {
      throw const GlucoseNotFinite();
    }
  }
}
