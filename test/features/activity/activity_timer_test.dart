import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/activity/activity_timer_page.dart';

/// Zamanlayıcı: duraklatma süreyi dondurur; bitir dakikayı yukarı yuvarlar;
/// hiç süre yokken bitir pasiftir.
void main() {
  late AppDatabase db;
  late DateTime fakeNow;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    fakeNow = DateTime(2026, 10, 23, 7);
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
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ActivityTimerPage(clock: () => fakeNow),
            ),
          ),
          child: const Text('open'),
        ),
      ),
    ),
  );

  testWidgets('hiç süre yokken bitir pasif', (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final finish = tester.widget<OutlinedButton>(
      find.ancestor(
        of: find.text('Finish and save'),
        matching: find.byType(OutlinedButton),
      ),
    );
    expect(finish.onPressed, isNull);
  });

  testWidgets('başlat, duraklat (süre donar), bitir: 90 sn → 2 dk kaydedilir', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start'));
    await tester.pump();
    fakeNow = fakeNow.add(const Duration(seconds: 60));
    await tester.tap(find.text('Pause'));
    await tester.pump();
    // Duraklatılmış süre ilerlemez.
    fakeNow = fakeNow.add(const Duration(minutes: 10));
    await tester.tap(find.text('Resume'));
    await tester.pump();
    fakeNow = fakeNow.add(const Duration(seconds: 30));

    await tester.tap(find.text('Finish and save'));
    await tester.pumpAndSettle();

    final row = await db.select(db.activitySession).getSingle();
    expect(row.kind, 'walk');
    expect(row.durationMinutes, 2);
  });
}
