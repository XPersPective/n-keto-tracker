import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';

/// Her desteklenen dil için Material/Cupertino/Widgets yerelleştirmesi yüklenir
/// ve uygulama metni çözülür (delegate eksikse yükleme hatası verir).
void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('yerel ayar yüklenir: $locale', (tester) async {
      late String title;
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              title = AppLocalizations.of(context)!.navToday;
              return Text(MaterialLocalizations.of(context).okButtonLabel);
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(title.trim(), isNotEmpty);
      expect(tester.takeException(), isNull);
    });
  }
}
