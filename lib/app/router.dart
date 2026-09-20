import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/today_page.dart';
import '../features/evidence/guide_page.dart';
import '../features/nutrition/meal_form.dart';
import '../features/weight/weight_form.dart';
import '../features/measurements/log_page.dart';
import '../features/measurements/measurement_session_form.dart';
import '../features/onboarding/onboarding_page.dart';
import 'app_shell.dart';
import 'l10n/generated/app_localizations.dart';

/// Uygulama yönlendiricisi (MASTER_PROMPT §5): 5 sekmeli ana kabuk +
/// onboarding akışı. Profil, ayarlar ve veri yönetimi sonraki görevlerde
/// üst menüye bağlanır.
final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/today',
              builder: (context, state) => const TodayPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/log',
              builder: (context, state) => const LogPage(),
              routes: [
                GoRoute(
                  path: 'session',
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(),
                    body: const MeasurementSessionForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/plan',
              builder: (context, state) => _PlaceholderPage(
                title: AppLocalizations.of(context)!.navPlan,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/trends',
              builder: (context, state) => _PlaceholderPage(
                title: AppLocalizations.of(context)!.navTrends,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/guide',
              builder: (context, state) => const GuidePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/meals/new', builder: (context, state) => const MealForm()),
    GoRoute(
      path: '/weight/new',
      builder: (context, state) => const WeightForm(),
    ),
    GoRoute(
      path: '/symptoms/new',
      builder: (context, state) =>
          _ComingSoonPage(title: AppLocalizations.of(context)!.todayAddSymptom),
    ),
  ],
);

/// Henüz uygulanmamış formlar için dürüst yer tutucu (T16/T22/T23).
class _ComingSoonPage extends StatelessWidget {
  const _ComingSoonPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.comingSoonTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(l10n.comingSoonBody, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sekme yer tutucusu: gerçek ekranlar kendi özellik görevlerinde (T13+)
/// bu yolların builder'larını değiştirir.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(l10n.pageUnderConstruction),
            const SizedBox(height: 24),
            Text(
              l10n.generalInfoDisclaimer,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
