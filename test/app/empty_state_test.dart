import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/app/theme/surfaces.dart';

/// PB-031: boş durum bileşeni.
///
/// Kural: boş bir bölüm, kullanıcıya **ne yapacağını** söyleyen bir eylem
/// sunmalıdır. Sadece "henüz kayıt yok" metni ölü bir uç noktadır.
void main() {
  Widget scope(Widget child) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );

  testWidgets('mesaj + eylem düğmesi görünür', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      scope(
        EmptyState(
          message: 'No meals recorded today.',
          actionLabel: 'Add meal',
          onAction: () => tapped = true,
        ),
      ),
    );
    expect(find.text('No meals recorded today.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Add meal'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Add meal'));
    expect(tapped, isTrue, reason: 'eylem düğmesi çalışmıyor');
  });

  testWidgets('eylem verilmezse düğme gösterilmez', (tester) async {
    await tester.pumpWidget(
      scope(const EmptyState(message: 'Nothing here yet.')),
    );
    expect(find.text('Nothing here yet.'), findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);
  });

  testWidgets('eylem etiketi var ama geri çağrım yoksa düğme gösterilmez', (
    tester,
  ) async {
    await tester.pumpWidget(
      scope(const EmptyState(message: 'X', actionLabel: 'Do it')),
    );
    expect(find.byType(FilledButton), findsNothing);
  });

  testWidgets('eylem düğmesi dokunma hedefi ≥48 px (PB-031)', (tester) async {
    await tester.pumpWidget(
      scope(
        EmptyState(
          message: 'X',
          actionLabel: 'Add',
          onAction: () {},
        ),
      ),
    );
    final size = tester.getSize(find.byType(FilledButton));
    expect(size.height, greaterThanOrEqualTo(48), reason: 'düğme çok alçak');
  });

  testWidgets('verilen ikon render edilir', (tester) async {
    await tester.pumpWidget(
      scope(
        const EmptyState(message: 'X', icon: Icons.restaurant_outlined),
      ),
    );
    expect(find.byIcon(Icons.restaurant_outlined), findsOneWidget);
  });

  testWidgets('TR lokalizasyonu bozulmaz', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: EmptyState(
            message: 'Bugün öğün kaydı yok.',
            actionLabel: 'Öğün ekle',
            onAction: () {},
          ),
        ),
      ),
    );
    expect(find.text('Bugün öğün kaydı yok.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Öğün ekle'), findsOneWidget);
  });
}