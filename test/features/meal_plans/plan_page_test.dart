import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/app/router.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/core/database/recipe_seeder.dart';
import 'package:n_keto_tracker/features/meal_plans/plan_page.dart';
import 'package:n_keto_tracker/features/shopping/shopping_list_page.dart';

/// T35 Plan ekranı testleri (MASTER_PROMPT §5.3 + §10.2): üret→kaydet→
/// alışveriş listesi oluşur. Risk kilidi ret linüközü T20 testinde zaten
/// kanıtlı (guardPlanGeneration PlanLockedException).
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Future<void> seedAll() async {
    await FoodSeeder(db)
        .seedFromJsonString(File('assets/seed/foods.json').readAsStringSync());
    await RecipeSeeder(
      db,
    ).seedFromJsonString(File('assets/seed/recipes.json').readAsStringSync());
  }

  Widget scope() => ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PlanPage(),
    ),
  );

  testWidgets('taslak üret: plan kaydedilir ve ekranda 7 gün görünür', (
    tester,
  ) async {
    await seedAll();
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    expect(find.text('Generate weekly draft'), findsOneWidget);
    await tester.tap(find.text('Generate weekly draft'));
    await tester.pumpAndSettle();

    expect((await db.select(db.mealPlan).get()), hasLength(1));
    // 7 gün × 2 öğün = 14 girdi.
    expect((await db.select(db.mealPlanEntry).get()), hasLength(14));
  });

  testWidgets('plandan alışveriş listesi oluşturulur', (tester) async {
    await seedAll();
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Generate weekly draft'));
    await tester.pumpAndSettle();
    expect((await db.select(db.mealPlan).get()), hasLength(1));

    // CTA AppBar'dadır; her zaman görünür.
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();

    expect((await db.select(db.shoppingList).get()), hasLength(1));
    expect((await db.select(db.shoppingListItem).get()), isNotEmpty);
  });

  // PB-022: Alışveriş listesi oluşturulduktan sonra ekran değişmeli
  // (önceki kod yalnız DB'ye yazıyor, kullanıcı hiçbir yere
  // gitmiyordu) ve "Shopping list opened." toastu gösterilmeli.
  testWidgets('PB-022: alışveriş sepetine dokununca liste ekranı açılır',
      (tester) async {
    await seedAll();
    appRouter.go('/plan');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Plan üret.
    await tester.tap(find.text('Generate weekly draft'));
    await tester.pumpAndSettle();
    expect((await db.select(db.mealPlan).get()), hasLength(1));

    // Sepet düğmesi.
    final cart = find.byIcon(Icons.shopping_cart_outlined);
    expect(cart, findsOneWidget);
    await tester.tap(cart);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Yönlendirme: ShoppingListPage açıldı.
    expect(find.byType(ShoppingListPage), findsOneWidget);
    // Boş durum değil, en az 1 madde.
    expect(find.text('No shopping list yet.'), findsNothing);
  });
}
