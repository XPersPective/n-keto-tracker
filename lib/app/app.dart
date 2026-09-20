import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/config/app_config.dart';
import 'l10n/generated/app_localizations.dart';
import 'router.dart';
import 'theme/app_theme.dart';

/// Uygulama kökü: tek tema üreticisi, TR/EN yerelleştirme, 5 sekmeli
/// yönlendirici. Marka adı tek yapılandırma noktasından gelir.
///
/// [localeOverride] yalnızca testlerde kullanılır; üretimde sistem/ilk
/// açılış seçimi (T9) belirler. Testler global [appRouter]'ı yeniden
/// kullanır (durumu pump'lar arası korunur).
class NKetoApp extends StatelessWidget {
  const NKetoApp({super.key, this.localeOverride});

  final Locale? localeOverride;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appBrandName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      locale: localeOverride,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
