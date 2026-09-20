/// Derleme zamanı yapılandırması (ORTAK_UYGULAMA_STANDARDI.md §1.2).
///
/// Değerler `--dart-define` ile verilir; repoda gizli değer tutulmaz.
/// Boş varsayılan = özellik devre dışı (ör. destek e-postası girilmemişse
/// Hakkında ekranı bağlantıyı göstermez).
class EnvConfig {
  const EnvConfig._();

  /// Destek e-postası (T28 Hakkında ekranında kullanılır).
  static const String supportEmail = String.fromEnvironment(
    'NKETO_SUPPORT_EMAIL',
    defaultValue: '',
  );

  /// Statik gizlilik politikası sayfası URL'si (T29; uygulama bu adrese
  /// kendisi istek atmaz — yalnızca kullanıcı eylemiyle harici tarayıcıda
  /// açılır).
  static const String privacyUrl = String.fromEnvironment(
    'NKETO_PRIVACY_URL',
    defaultValue: '',
  );
}
