import 'package:flutter/widgets.dart';

/// Dillerin kendi adıyla (endonym) gösterimi; seçici listeleri bu sırayı
/// kullanır. Yeni dil eklenince ARB + bu harita birlikte güncellenir
/// (l10n_completeness_test kapsamayı doğrular).
const Map<String, String> languageEndonyms = {
  'tr': 'Türkçe',
  'en': 'English',
  'es': 'Español',
  'pt': 'Português',
  'fr': 'Français',
  'de': 'Deutsch',
  'it': 'Italiano',
  'nl': 'Nederlands',
  'pl': 'Polski',
  'ru': 'Русский',
  'uk': 'Українська',
  'ar': 'العربية',
  'hi': 'हिन्दी',
  'id': 'Bahasa Indonesia',
  'vi': 'Tiếng Việt',
  'ja': '日本語',
  'ko': '한국어',
  'zh': '中文 (简体)',
  'zh_Hant': '中文 (繁體)',
  'af': 'Afrikaans',
  'az': 'Azərbaycanca',
  'be': 'Беларуская',
  'bg': 'Български',
  'bn': 'বাংলা',
  'ca': 'Català',
  'cs': 'Čeština',
  'da': 'Dansk',
  'el': 'Ελληνικά',
  'et': 'Eesti',
  'eu': 'Euskara',
  'fa': 'فارسی',
  'fi': 'Suomi',
  'fil': 'Filipino',
  'gl': 'Galego',
  'gu': 'ગુજરાતી',
  'he': 'עברית',
  'hr': 'Hrvatski',
  'hu': 'Magyar',
  'hy': 'Հայերեն',
  'is': 'Íslenska',
  'ka': 'ქართული',
  'kk': 'Қазақша',
  'kn': 'ಕನ್ನಡ',
  'ky': 'Кыргызча',
  'lo': 'ລາວ',
  'lt': 'Lietuvių',
  'lv': 'Latviešu',
  'mk': 'Македонски',
  'ml': 'മലയാളം',
  'mn': 'Монгол',
  'mr': 'मराठी',
  'ms': 'Bahasa Melayu',
  'my': 'မြန်မာ',
  'ne': 'नेपाली',
  'pa': 'ਪੰਜਾਬੀ',
  'ro': 'Română',
  'si': 'සිංහල',
  'sk': 'Slovenčina',
  'sl': 'Slovenščina',
  'sq': 'Shqip',
  'sr': 'Српски',
  'sv': 'Svenska',
  'sw': 'Kiswahili',
  'ta': 'தமிழ்',
  'te': 'తెలుగు',
  'th': 'ไทย',
  'ur': 'اردو',
  'zu': 'isiZulu',
};

/// Kayıtlı dil kodunu [Locale]'e çevirir ('zh_Hant' → zh + Hant yazısı).
Locale localeFromCode(String code) {
  final parts = code.split('_');
  return parts.length == 2
      ? Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1])
      : Locale(code);
}

/// [localeFromCode]'un tersi; endonym haritasındaki anahtar biçimi.
String codeFromLocale(Locale l) =>
    l.scriptCode == null ? l.languageCode : '${l.languageCode}_${l.scriptCode}';
