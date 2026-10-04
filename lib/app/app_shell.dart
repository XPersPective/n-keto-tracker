import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/monetization/ad_banner.dart';
import 'l10n/generated/app_localizations.dart';

/// Alt navigasyon kabuğu: en fazla 5 ana hedef (MASTER_PROMPT §5).
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reklam yalnız klinik olmayan Plan sekmesinde (ADR-PB-012).
          if (navigationShell.currentIndex == 2) const AdBanner(),
          NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: l10n.navToday,
              ),
              NavigationDestination(
                icon: const Icon(Icons.receipt_long_outlined),
                selectedIcon: const Icon(Icons.receipt_long),
                label: l10n.navLog,
              ),
              NavigationDestination(
                icon: const Icon(Icons.calendar_month_outlined),
                selectedIcon: const Icon(Icons.calendar_month),
                label: l10n.navPlan,
              ),
              NavigationDestination(
                icon: const Icon(Icons.show_chart),
                label: l10n.navTrends,
              ),
              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),
                selectedIcon: const Icon(Icons.menu_book),
                label: l10n.navGuide,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
