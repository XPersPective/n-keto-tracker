import 'package:flutter/material.dart';

/// Tek tema üreticisi (MASTER_PROMPT §12 / ORTAK §3.1).
///
/// Açık/koyu/sistem üç modu tek tohum renginden üretilir; token dışı renk
/// kullanımı yasaktır. Sakin, yüksek kontrast, en fazla bir ana vurgu rengi
/// (MASTER_PROMPT §22.4).
abstract final class AppTheme {
  /// Ana vurgu rengi: sakin teal. Kırmızı yalnız klinik onaylı acil
  /// mesajlarda kullanılacaktır (MASTER_PROMPT §6.6).
  static const Color seedColor = Color(0xFF00696B);

  static ThemeData light() =>
      _build(ColorScheme.fromSeed(seedColor: seedColor));

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
  );

  static ThemeData _build(ColorScheme scheme) {
    return ThemeData(useMaterial3: true, colorScheme: scheme).copyWith(
      // Dokunma hedefleri ≥48dp (MASTER_PROMPT §12): alt navigasyon yüksek
      // tutulur; butonlar/etiketler için minimum görsel alan.
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 12, color: scheme.onSurface),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme: IconThemeData(color: scheme.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      ),
      // Formlar hataya dayanıklı ve büyük dokunma alanlı olmalı (§0.1).
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
