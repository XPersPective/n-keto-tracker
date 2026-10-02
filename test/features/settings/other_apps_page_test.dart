import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/features/settings/other_apps_page.dart';

/// PB-009 Diğer uygulamalar sayfası testleri (ORTAK §3.6, ADR-0004):
/// boş katalogda otherAppsEmpty; bozuk/şema dışı JSON çökmez; geçerli
/// kayıt kart olur, mağaza bağlantısı panoya kopyalanır (açılmaz).
void main() {
  Widget scope({Future<List<OtherApp>> Function()? loadApps}) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: OtherAppsPage(loadApps: loadApps),
  );

  const exampleApp = OtherApp(
    id: 'ornek',
    packageName: 'com.crazypenguin.ornek',
    name: 'Example',
    description: 'One line about it.',
    storeUrl:
        'https://play.google.com/store/apps/details?id=com.crazypenguin.ornek',
  );

  testWidgets('empty catalog: empty-state text', (tester) async {
    await tester.pumpWidget(scope(loadApps: () async => const []));
    await tester.pumpAndSettle();

    expect(find.text('Other apps'), findsOneWidget);
    expect(find.text('No other apps listed yet.'), findsOneWidget);
  });

  testWidgets('loading spinner, then card', (tester) async {
    final loader = Completer<List<OtherApp>>();
    await tester.pumpWidget(scope(loadApps: () => loader.future));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    loader.complete(const [exampleApp]);
    await tester.pumpAndSettle();

    expect(find.text('Example'), findsOneWidget);
    expect(find.text('One line about it.'), findsOneWidget);
    // Bağlantı açma yok (url_launcher kullanılmıyor): mağaza adresi
    // yalnız panoya kopyalanır.
    expect(find.byIcon(Icons.open_in_new), findsNothing);
  });

  testWidgets('tapping a card shows the copied toast', (tester) async {
    await tester.pumpWidget(scope(loadApps: () async => const [exampleApp]));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Example'));
    await tester.pumpAndSettle();

    expect(find.text('Copied to clipboard.'), findsOneWidget);
  });

  test('malformed JSON returns empty list without throwing', () {
    expect(loadOtherAppsFromJson('not json {'), isEmpty);
  });

  test('non-schema root and wrong schema number return empty list', () {
    expect(loadOtherAppsFromJson('[1,2,3]'), isEmpty);
    expect(loadOtherAppsFromJson('{"schema": 2, "apps": []}'), isEmpty);
  });

  test('invalid records are skipped, valid record parses', () {
    final apps = loadOtherAppsFromJson('''
{
  "schema": 1,
  "apps": [
    {"id": "eksik_alan"},
    "string kayıt",
    {"id": "", "androidPackage": "com.x.y"},
    {
      "id": "ornek",
      "androidPackage": "com.crazypenguin.ornek",
      "name": {"en": "Example", "tr": "Örnek"},
      "description": {"en": "One line.", "tr": "Tek cümle."},
      "order": 1
    }
  ]
}
''');
    expect(apps.length, 1);
    expect(apps.first.id, 'ornek');
    expect(apps.first.packageName, 'com.crazypenguin.ornek');
    expect(
      apps.first.storeUrl,
      'https://play.google.com/store/apps/details?id=com.crazypenguin.ornek',
    );
  });

  test('localized text falls back to English', () {
    final apps = loadOtherAppsFromJson('''
{
  "schema": 1,
  "apps": [
    {"id": "a", "androidPackage": "com.a.b", "name": {"tr": "Yalnız TR"},
     "description": {"en": "EN desc"}}
  ]
}
''');
    expect(apps.single.name, 'Yalnız TR');
    expect(apps.single.description, 'EN desc');
  });

  test('embedded assets/apps.json parses (currently empty catalog)', () async {
    final apps = await loadOtherApps();
    expect(apps, isEmpty);
  });
}
