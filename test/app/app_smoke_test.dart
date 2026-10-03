import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/app.dart';
import 'package:n_keto_tracker/app/router.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';

void main() {
  ProviderScope dbScope(Widget child) {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() async {
      await (db).close();
    });
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: child,
    );
  }

  testWidgets('İlk yol onboarding ilk adımı (dil seçimi)', (tester) async {
    await tester.pumpWidget(dbScope(const NKetoApp()));
    await tester.pumpAndSettle();

    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('Türkçe'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('Ana kabuk: /today yolunda 5 sekme + Bugün placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(dbScope(const NKetoApp()));
    await tester.pumpAndSettle();
    appRouter.go('/today');
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Today'), findsWidgets);
    expect(find.text('Log'), findsWidgets);
    expect(find.text('Plan'), findsWidgets);
    expect(find.text('Trends'), findsOneWidget);
    expect(find.text('Guide'), findsOneWidget);
    // Bugün artık gerçek ekran: hızlı eylemler görünür.
    expect(find.text('Add measurement'), findsOneWidget);
  });

  testWidgets('Her sekme dokunuşla açılır', (tester) async {
    await tester.pumpWidget(dbScope(const NKetoApp()));
    await tester.pumpAndSettle();
    appRouter.go('/today');
    await tester.pumpAndSettle();

    // Sıra, turun 'Today' ile bitmesiyle router durumunu geri bırakır.
    for (final label in ['Log', 'Plan', 'Trends', 'Guide', 'Today']) {
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();
      expect(find.text(label), findsWidgets);
    }
  });

  testWidgets('TR yerel ayarında onboarding Türkçe', (tester) async {
    // Global router önceki testlerde /today'e taşınmış olabilir.
    appRouter.go('/onboarding');
    await tester.pumpWidget(
      const ProviderScope(child: NKetoApp(localeOverride: Locale('tr'))),
    );
    await tester.pump(); // locale çözümlemesi için ilk kare
    await tester.pumpAndSettle();

    expect(find.text('Dilinizi seçin'), findsOneWidget);
    expect(
      find.text('Kabul ediyorum'),
      findsNothing,
      reason: 'onam kutusu yalnız son adımda',
    );
  });
}
