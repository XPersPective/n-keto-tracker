import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/symptoms/symptom_form.dart';

/// T23 semptom formu widget testi (MASTER_PROMPT §11.2): yönlendirme
/// mesajı (nöbet olayı / şiddet ≥7), kayıt DB'ye yazılır.
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
      home: SymptomForm(),
    ),
  );

  testWidgets('düşük şiddetli belirti: mesaj yok, kayıt oluşur', (
    tester,
  ) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    expect(find.textContaining('does not diagnose'), findsNothing);
    await tester.tap(find.text('Save symptom'));
    await tester.pumpAndSettle();

    expect((await db.select(db.symptomEntry).get()), hasLength(1));
  });

  testWidgets('şiddet 8: yönlendirme mesajı görünür', (tester) async {
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Slider'ı 8'e taşı (0–10, 10 bölüm).
    final slider = find.byType(Slider);
    await tester.drag(slider, const Offset(150, 0));
    await tester.pumpAndSettle();

    expect(find.textContaining('This app does not diagnose'), findsOneWidget);
  });
}
