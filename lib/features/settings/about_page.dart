import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/l10n/generated/app_localizations.dart';
import '../../core/config/env_config.dart';

/// Hakkında sayfası (ORTAK §3.3, PB-002): logo+ad+sürüm, açık kaynak
/// bölümü, gizlilik özeti, feragat, Lisanslar'a bağlantı, Paylaş.
/// Bağlantılar ağ çağrısı yapmaz — yalnız kopyalanabilir metindir.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  static const String _repoUrl =
      'https://github.com/XPersPective/n-keto-tracker';

  Future<void> _shareApp(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    await SharePlus.instance.share(
      ShareParams(text: '${l10n.appTitle} — ${l10n.aboutShareText} $_repoUrl'),
    );
  }

  void _copyRepo(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: _repoUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.aboutCopiedToast)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final version = const String.fromEnvironment(
      'APP_VERSION',
      defaultValue: 'dev',
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/brand/brand_icon_1024.png',
                    width: 96,
                    height: 96,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.appTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  l10n.aboutSlogan,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(l10n.aboutVersion(version)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aboutOpenSourceHeading,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.aboutOpenSourceBody),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.copy),
                    label: Text(_repoUrl),
                    onPressed: () => _copyRepo(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aboutPrivacyHeading,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.aboutPrivacyBody),
                  if (EnvConfig.privacyUrl.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.copy),
                      label: Text(EnvConfig.privacyUrl),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: EnvConfig.privacyUrl),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.aboutCopiedToast)),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aboutDisclaimerHeading,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.aboutDisclaimerBody),
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
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.aboutLicensesButton),
            onTap: () {
              // ORTAK §3.4: showLicensePage + üstte uygulama lisansı.
              showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
                applicationVersion: version,
                applicationIcon: Image.asset(
                  'assets/brand/brand_icon_1024.png',
                  width: 64,
                  height: 64,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(l10n.aboutShareButton),
            onTap: () => _shareApp(context),
          ),
          ListTile(
            leading: const Icon(Icons.apps_outlined),
            title: Text(l10n.aboutOtherAppsButton),
            onTap: () => context.push('/settings/other-apps'),
          ),
        ],
      ),
    );
  }
}
