import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/l10n/language_names.dart';
import '../../app/locale_provider.dart';
import '../../core/database/settings_repository.dart';
import '../../core/monetization/ad_banner.dart';
import '../../core/monetization/ads_controller.dart';
import '../../core/monetization/monetization_config.dart';
import '../../core/monetization/premium_controller.dart';

/// Ayarlar: görünüm (Sistem/Açık/Koyu), dil, veri yönetimi, hakkında.
/// Tercihler AppSettings'e yazılır ve anında uygulanır.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(settingsRepositoryProvider);
    final mode = ref.watch(appThemeModeProvider);
    final current =
        ref.watch(appLocaleProvider)?.languageCode ??
        Localizations.localeOf(context).languageCode;

    final premium = ref.watch(premiumProvider);
    final adsState = ref.watch(adsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      bottomNavigationBar: const SafeArea(
        child: Center(heightFactor: 1, child: AdBanner()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (MonetizationConfig.supported) ...[
            _PremiumCard(state: premium),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsAppearance,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: const Icon(Icons.brightness_auto_outlined),
                          label: Text(l10n.themeSystem),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: const Icon(Icons.light_mode_outlined),
                          label: Text(l10n.themeLight),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: const Icon(Icons.dark_mode_outlined),
                          label: Text(l10n.themeDark),
                        ),
                      ],
                      selected: {mode},
                      onSelectionChanged: (s) async {
                        await repo.saveThemeMode(s.first.name);
                        ref.invalidate(appSettingsProvider);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsLanguage,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  RadioGroup<String>(
                    groupValue: current,
                    onChanged: (code) async {
                      if (code == null) return;
                      await repo.saveLanguage(code);
                      ref.invalidate(appSettingsProvider);
                    },
                    child: Column(
                      children: [
                        for (final code in languageEndonyms.keys)
                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            value: code,
                            title: Text(languageEndonyms[code]!),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: Text(l10n.dataManagementTitle),
            onTap: () => context.push('/settings/data'),
          ),
          if (adsState.privacyOptionsRequired)
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(l10n.adsPrivacyOptions),
              onTap: () => ref.read(adsProvider.notifier).showPrivacyOptions(),
            ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.aboutTitle),
            onTap: () => context.push('/settings/about'),
          ),
        ],
      ),
    );
  }
}

/// Reklamsız Premium kartı: satın al / geri yükle / etkin durumu.
class _PremiumCard extends ConsumerWidget {
  const _PremiumCard({required this.state});

  final PremiumState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final ctrl = ref.read(premiumProvider.notifier);
    return Card(
      color: scheme.primary.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.workspace_premium_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  l10n.premiumTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (state.premium)
              Text(l10n.premiumActive)
            else ...[
              Text(
                l10n.premiumHeading,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(l10n.premiumBody),
              const SizedBox(height: 12),
              if (state.available && state.price != null)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.busy ? null : ctrl.buy,
                    child: Text(l10n.premiumBuy(state.price!)),
                  ),
                )
              else
                Text(
                  l10n.premiumUnavailable,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              TextButton(
                onPressed: ctrl.restore,
                child: Text(l10n.premiumRestore),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
