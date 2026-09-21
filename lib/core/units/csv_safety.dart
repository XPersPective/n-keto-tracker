/// CSV güvenliği ve dışa aktarma yardımcıları (MASTER_PROMPT §14.3, T26).
///
/// Formül enjeksiyonu koruması: hücre değerleri =, +, -, @ ile başlıyorsa
/// önde tek tırnakla nötrlenir; virgül/tırnak/yeni satır içeren değerler
/// tırnak içine alınır.
library;

/// Tek CSV satırı üretir.
String csvRow(List<Object?> cells) {
  return cells.map(csvCell).join(',');
}

String csvCell(Object? value) {
  var s = value?.toString() ?? '';
  if (s.isNotEmpty && '=+-@'.contains(s[0])) {
    s = "'$s";
  }
  if (s.contains(',') || s.contains('"') || s.contains('\n')) {
    s = '"${s.replaceAll('"', '""')}"';
  }
  return s;
}

/// İçe aktarım boyut limiti (bayt): küçük sağlık günlüğü için cömert.
const int maxImportBytes = 5 * 1024 * 1024;

/// İçe aktarımın desteklediği format sürümü (eski format okunur).
const Set<String> supportedImportVersions = {'1.0'};

/// JSON başlığını doğrular; sorun varsa [ImportValidationException].
void validateImportHeader({
  required Map<String, dynamic> doc,
  required int rawBytes,
}) {
  if (rawBytes > maxImportBytes) {
    throw const ImportValidationException('file too large');
  }
  final version = doc['formatVersion'];
  if (version is! String || !supportedImportVersions.contains(version)) {
    throw const ImportValidationException('unsupported formatVersion');
  }
  if (doc['schemaVersion'] is! int) {
    throw const ImportValidationException('missing schemaVersion');
  }
}

class ImportValidationException implements Exception {
  const ImportValidationException(this.message);

  final String message;

  @override
  String toString() => 'IMPORT_VALIDATION: $message';
}
