import 'formula_version.dart';

/// Glukoz birimi.
enum GlucoseUnit { mgDl, mmolL }

/// Glukoz değeri doğrulama hataları (MASTER_PROMPT §2.4, §15: sessiz
/// clamp yok, anlamsız değer reddedilir).
sealed class GlucoseValidationError implements Exception {
  const GlucoseValidationError();

  @override
  String toString() => switch (this) {
    GlucoseNotPositive() => 'GLUCOSE_MUST_BE_POSITIVE',
    GlucoseNotFinite() => 'NOT_A_FINITE_NUMBER',
    GlucoseEmptyInput() => 'EMPTY_INPUT',
  };
}

class GlucoseNotPositive extends GlucoseValidationError {
  const GlucoseNotPositive();
}

class GlucoseNotFinite extends GlucoseValidationError {
  const GlucoseNotFinite();
}

class GlucoseEmptyInput extends GlucoseValidationError {
  const GlucoseEmptyInput();
}

/// Ham glukoz değeri + birim; normalize mmol/L ile birlikte taşınır
/// (MASTER §6.2: ham değer/ham birim ve normalize değer birlikte saklanır).
class GlucoseValue {
  const GlucoseValue._({
    required this.rawValue,
    required this.unit,
    required this.mmolL,
  });

  final double rawValue;
  final GlucoseUnit unit;

  /// Normalize değer: mg/dL ise /18.0; mmol/L ise aynen. Ara yuvarlama
  /// yapılmaz.
  final double mmolL;

  /// Kullanıcının girdiği ham değer/birimden güvenli değer üretir.
  ///
  /// Girdi zaten mmol/L ise dönüşüm TEKRAR UYGULANMAZ (MASTER §16.1).
  /// - value ≤ 0 → [GlucoseNotPositive]
  /// - NaN/Infinity → [GlucoseNotFinite]
  static GlucoseValue fromRaw(double value, GlucoseUnit unit) {
    if (value.isNaN || value.isInfinite) {
      throw const GlucoseNotFinite();
    }
    if (value <= 0) {
      throw const GlucoseNotPositive();
    }
    final mmolL = switch (unit) {
      GlucoseUnit.mgDl => value / glucoseMgDlToMmolL,
      GlucoseUnit.mmolL => value,
    };
    return GlucoseValue._(rawValue: value, unit: unit, mmolL: mmolL);
  }
}

/// Kullanıcı girdisini sayıya çevirir: TR virgülü ve EN noktası ondalık
/// ayracı olarak kabul eder (MASTER §3.3); boş/whitespace ve sayı olmayan
/// girdi reddedilir.
double parseDecimal(String input) {
  final normalized = input.trim();
  if (normalized.isEmpty) {
    throw const GlucoseEmptyInput();
  }
  // Türkçe biçimde binlik ayraç nokta olabilir (ör. '1.234,5'); hem
  // '1,234.5' (EN) hem '1.234,5' (TR) desteklenir.
  final hasComma = normalized.contains(',');
  final hasDot = normalized.contains('.');
  String canonical;
  if (hasComma && hasDot) {
    // Son görünen ayraç ondalıktır.
    canonical = normalized.lastIndexOf(',') > normalized.lastIndexOf('.')
        ? normalized.replaceAll('.', '').replaceFirst(',', '.')
        : normalized.replaceAll(',', '');
  } else if (hasComma) {
    canonical = normalized.replaceFirst(',', '.');
  } else {
    canonical = normalized;
  }
  final value = double.tryParse(canonical);
  if (value == null) {
    throw const GlucoseNotFinite();
  }
  return value;
}
