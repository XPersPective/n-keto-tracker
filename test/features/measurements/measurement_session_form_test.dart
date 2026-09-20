import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/measurements_repository.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/measurements/measurement_session_form.dart';

/// T12 form widget testleri: geçerli girişte oturum kaydedilir + GKI
/// kartı formül ve saat gösterir; geçersiz girişte hata mesajı ve kayıt
/// yok (MASTER_PROMPT §6.2, §16.3).
void main() {
  late AppDatabase db;

  Widget harness() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    return ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        measurementsRepositoryProvider.overrideWithValue(
          MeasurementsRepository(db),
        ),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: MeasurementSessionForm()),
      ),
    );
  }

  tearDown(() async => db.close());

  testWidgets('90 mg/dL + 2,5 → kaydeder ve GKI 2,0 kartını gösterir', (
    tester,
  ) async {
    await tester.pumpWidget(harness());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Glucose (mg/dL)').first,
      '90',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Blood ketone BHB (mmol/L)').first,
      '2,5', // TR virgülü kabul edilmeli
    );
    await tester.tap(find.text('Save measurement session'));
    await tester.pumpAndSettle();

    expect(find.textContaining('GKI: 2.0'), findsOneWidget);
    expect(find.textContaining('÷ 2.5 mmol/L'), findsOneWidget);
    expect(find.textContaining('5.0 mmol/L'), findsOneWidget);
    expect(find.textContaining('gki-v1'), findsOneWidget);
    // DB'de oturum gerçekten oluştu.
    expect((await db.select(db.measurementSession).get()), hasLength(1));
  });

  testWidgets('geçersiz değer hata gösterir; kayıt yapmaz', (tester) async {
    await tester.pumpWidget(harness());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Glucose (mg/dL)').first,
      '-5',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Blood ketone BHB (mmol/L)').first,
      '2.5',
    );
    await tester.tap(find.text('Save measurement session'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid positive number.'), findsOneWidget);
    expect((await db.select(db.measurementSession).get()), isEmpty);
  });

  testWidgets('BHB sıfır reddedilir (GKI yok)', (tester) async {
    await tester.pumpWidget(harness());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Glucose (mg/dL)').first,
      '90',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Blood ketone BHB (mmol/L)').first,
      '0',
    );
    await tester.tap(find.text('Save measurement session'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid positive number.'), findsOneWidget);
    expect((await db.select(db.measurementSession).get()), isEmpty);
  });
}
