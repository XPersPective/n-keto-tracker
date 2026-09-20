import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/weight/weight_form.dart';

/// T22 ağırlık formu widget testi (MASTER_PROMPT §11.1): kg/lb normalize
/// kayıt; geçersiz değer reddi; rozet/seri dili yok.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Widget scope() => ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: WeightForm(),
    ),
  );

  testWidgets('lb girişi normalize kg saklanır', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.tap(find.text('lb'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Weight (lb)').first,
      '150',
    );
    await tester.tap(find.text('Save weight'));
    await tester.pumpAndSettle();

    final row = await db.select(db.weightEntry).getSingle();
    expect(row.rawUnit, 'lb');
    expect(row.rawValue, 150);
    expect(row.kg, closeTo(68.0389, 1e-4));
  });

  testWidgets('geçersiz değer: hata mesajı, kayıt yok', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Weight (kg)').first,
      '-5',
    );
    await tester.tap(find.text('Save weight'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid positive number.'), findsOneWidget);
    expect((await db.select(db.weightEntry).get()), isEmpty);
  });

  testWidgets('koşul ve not alanları kaydedilir', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Weight (kg)').first,
      '72,5', // TR virgülü
    );
    await tester.enterText(
      find
          .widgetWithText(
            TextField,
            'Condition (optional, e.g. morning, after workout)',
          )
          .first,
      'sabah aç',
    );
    await tester.tap(find.text('Save weight'));
    await tester.pumpAndSettle();

    final row = await db.select(db.weightEntry).getSingle();
    expect(row.kg, 72.5);
    expect(row.conditionNote, 'sabah aç');
  });
}
