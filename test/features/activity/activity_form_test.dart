import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/activity/activity_form.dart';

/// Hareket formu: geçersiz süre reddi; mesafeli koşu kaydı kalıcı olur.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Widget app() => ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Builder(
        builder: (context) => FilledButton(
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute<void>(builder: (_) => const ActivityForm())),
          child: const Text('open'),
        ),
      ),
    ),
  );

  testWidgets('geçersiz süre: hata mesajı, kayıt yok', (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Duration (minutes)'),
      '0',
    );
    await tester.tap(find.text('Save activity'));
    await tester.pumpAndSettle();

    expect(
      find.text('Enter a duration from 1 to 600 minutes.'),
      findsOneWidget,
    );
    expect(await db.select(db.activitySession).get(), isEmpty);
  });

  testWidgets('koşu, 30 dk ve 5 km: kayıt kalıcı olur', (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Run'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Duration (minutes)'),
      '30',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Distance in km (optional)'),
      '5',
    );
    await tester.tap(find.text('Save activity'));
    await tester.pumpAndSettle();

    final row = await db.select(db.activitySession).getSingle();
    expect(row.kind, 'run');
    expect(row.durationMinutes, 30);
    expect(row.distanceKm, 5);
  });
}
