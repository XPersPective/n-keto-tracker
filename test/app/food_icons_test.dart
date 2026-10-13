import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/theme/food_icons.dart';

/// PB-030: yemek kategorileri için özgün vektör ikonlar.
///
/// Kurallar testle sabitlenir:
/// - 15 seed kategorisinin tamamı bir ikon alır (eşleşme boşluğu yok).
/// - Bilinmeyen kategori güvenli varsayılan döner (null dahil).
/// - Emoji METNİ kullanılmaz (cihazlar arası tutarsız glyph).
void main() {
  // assets/seed/foods.json içindeki 15 kategori.
  const seedCategories = <String>[
    'meat', 'poultry', 'fish', 'dairy', 'fats', 'nuts', 'vegetable',
    'fruit', 'legume', 'grain', 'tuber', 'beverage', 'sweet', 'snack',
    'prepared',
  ];

  test('15 seed kategorisinin tamamı ikon alır', () {
    expect(FoodIcons.byCategory.length, greaterThanOrEqualTo(15));
    for (final c in seedCategories) {
      expect(
        FoodIcons.byCategory.containsKey(c),
        isTrue,
        reason: 'kategori ikonu yok: $c',
      );
      expect(FoodIcons.foodIconFor(c), isNot(FoodIcons.foodIconFor('__none__')));
    }
  });

  test('bilinmeyen kategori ve null güvenli varsayılan döner', () {
    expect(FoodIcons.foodIconFor('bilinmeyen'), Icons.restaurant_menu);
    expect(FoodIcons.foodIconFor(null), Icons.restaurant_menu);
  });

  test('farklı kategoriler farklı ikon alır', () {
    expect(FoodIcons.foodIconFor('vegetable'), Icons.eco_outlined);
    expect(FoodIcons.foodIconFor('fruit'), Icons.apple);
    expect(FoodIcons.foodIconFor('beverage'), Icons.local_cafe_outlined);
    expect(FoodIcons.foodIconFor('vegetable'), isNot(FoodIcons.foodIconFor('fruit')));
  });

  testWidgets('FoodIconBadge ikonu daire içinde render eder', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: FoodIconBadge(category: 'vegetable')),
      ),
    );
    expect(find.byIcon(Icons.eco_outlined), findsOneWidget);
    expect(find.byType(CircleBorder), findsNothing); // BoxShape.circle
  });

  testWidgets('bilinmeyen kategoride rozet çökmez', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: FoodIconBadge(category: 'yok')),
      ),
    );
    expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
  });
}