import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/monetization/ads_controller.dart';
import 'l10n/generated/app_localizations.dart';
import 'locale_provider.dart';
import 'router.dart';
import 'theme/app_theme.dart';

/// Uygulama kökü: tek tema üreticisi, TR/EN yerelleştirme, 5 sekmeli
/// yönlendirici. Marka adı tek yapılandırma noktasından gelir.
///
/// [localeOverride] yalnızca testlerde kullanılır; üretimde yerel ayar
/// kayıtlı tercihten (appLocaleProvider), kayıt yokken cihaz dilinden
/// çözülür (ORTAK §3.1). Testler global [appRouter]'ı yeniden
/// kullanır (durumu pump'lar arası korunur).
class NKetoApp extends ConsumerWidget {
  const NKetoApp({super.key, this.localeOverride});

  final Locale? localeOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(adsProvider); // UMP onamı + AdMob başlatma (yalnız Android)
    return MaterialApp.router(
      title: AppConfig.appBrandName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(appThemeModeProvider),
      locale: localeOverride ?? ref.watch(appLocaleProvider),
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
