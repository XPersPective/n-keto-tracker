import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../app/l10n/language_names.dart';
import '../../app/locale_provider.dart';
import '../../core/database/settings_repository.dart';

/// Ayarlar: görünüm (Sistem/Açık/Koyu), dil, veri yönetimi, hakkında.
/// Tercihler AppSettings'e yazılır ve anında uygulanır.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(settingsRepositoryProvider);
    final mode = ref.watch(appThemeModeProvider);
    final current = codeFromLocale(
      ref.watch(appLocaleProvider) ?? Localizations.localeOf(context),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
