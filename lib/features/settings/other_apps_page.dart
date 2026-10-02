import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, rootBundle;

import '../../app/l10n/generated/app_localizations.dart';

/// ORTAK §3.6 "Diğer Uygulamalarımız" — çevrimdışı uyarlama (ADR-0004).
///
/// Standart veri kaynağı GitHub raw apps.json'dur; bu uygulama INTERNET
/// izni olmadan tamamen çevrimdışı çalıştığından sürüme gömülü kopya
/// (`assets/apps.json`) gösterilir. Yeni uygulama yayınlamak = depodaki
/// apps.json'a kayıt eklemek + bir sonraki sürüme gömmek.
///
/// Dışarıdan gelen veri (§1.4): bozuk JSON çökertmez; şema uymazsa ya da
/// kayıt geçersizse o kayıt atlanır. Mağaza bağlantısı yalnız panoya
/// kopyalanır (yerleşik "URL yalnız kopyala" kalıbı; url_launcher yok).
class OtherAppsPage extends StatefulWidget {
  const OtherAppsPage({super.key, this.loadApps});

  /// Testler için enjekte edilebilir yükleyici; varsayılan gömülü varlık.
  final Future<List<OtherApp>> Function()? loadApps;

  static const String assetPath = 'assets/apps.json';

  @override
  State<OtherAppsPage> createState() => _OtherAppsPageState();
}

class _OtherAppsPageState extends State<OtherAppsPage> {
  List<OtherApp>? _apps;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final apps = await (widget.loadApps ?? loadOtherApps)();
    if (mounted) {
      setState(() => _apps = apps);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final apps = _apps;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.otherAppsTitle)),
      body: switch (apps) {
        null => const Center(child: CircularProgressIndicator()),
        [] => Center(child: Text(l10n.otherAppsEmpty)),
        final list => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) => _OtherAppCard(app: list[index]),
        ),
      },
    );
  }
}

/// Gömülü kataloğu okur ve doğrular; şema uyuşmazsa boş liste döner.
List<OtherApp> loadOtherAppsFromJson(String raw) {
  Object? decoded;
  try {
    decoded = jsonDecode(raw);
  } on FormatException {
    return const [];
  }
  if (decoded is! Map<String, Object?>) return const [];
  if (decoded['schema'] != 1) return const [];
  final apps = decoded['apps'];
  if (apps is! List<Object?>) return const [];
  final valid = <OtherApp>[];
  for (final entry in apps) {
    final app = OtherApp.tryParse(entry);
    if (app != null) valid.add(app);
  }
  return valid;
}

Future<List<OtherApp>> loadOtherApps() async {
  final raw = await rootBundle.loadString(OtherAppsPage.assetPath);
  return loadOtherAppsFromJson(raw);
}

class OtherApp {
  const OtherApp({
    required this.id,
    required this.packageName,
    required this.name,
    required this.description,
    required this.storeUrl,
  });

  final String id;
  final String packageName;
  final String name;
  final String description;
  final String storeUrl;

  /// Geçersiz kayıt null döner (§1.4: bozuk kayıt atlanır).
  static OtherApp? tryParse(Object? entry) {
    if (entry is! Map<String, Object?>) return null;
    final id = entry['id'];
    final androidPackage = entry['androidPackage'];
    final name = _localizedText(entry['name']);
    final description = _localizedText(entry['description']);
    if (id is! String || id.isEmpty) return null;
    if (androidPackage is! String || androidPackage.isEmpty) return null;
    if (name == null || description == null) return null;
    return OtherApp(
      id: id,
      packageName: androidPackage,
      name: name,
      description: description,
      storeUrl: 'https://play.google.com/store/apps/details?id=$androidPackage',
    );
  }

  /// {en: ..., tr: ...} haritasından metin seçer; EN yedekli.
  static String? _localizedText(Object? value) {
    if (value is String && value.isNotEmpty) return value;
    if (value is Map<String, Object?>) {
      final en = value['en'];
      if (en is String && en.isNotEmpty) return en;
      for (final v in value.values) {
        if (v is String && v.isNotEmpty) return v;
      }
    }
    return null;
  }
}

class _OtherAppCard extends StatelessWidget {
  const _OtherAppCard({required this.app});

  final OtherApp app;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.android_outlined),
        title: Text(app.name),
        subtitle: Text(app.description),
        trailing: Tooltip(
          message: l10n.otherAppsCopyLink,
          child: const Icon(Icons.copy, size: 20),
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: app.storeUrl));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.aboutCopiedToast)));
        },
      ),
    );
  }
}
