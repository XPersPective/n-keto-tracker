import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/features/measurements/log_page.dart';

/// T13 Günlük ekranı testleri (MASTER_PROMPT §5.2, §6.4, §12):
/// bantlar varsayılan KAPALI, açıklama metni kapalıyken de görünür,
/// boş durum render edilir, kayıt eklenince çizelgede görünür.
void main() {
  late AppDatabase db;

  // Widget ağacını söküp sonra DB'yi kapat (autoDispose sorguları için).
  Future<void> gracefulTeardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await db.close();
  }

  Widget scope() {
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LogPage(),
      ),
    );
  }

  testWidgets('boş durum + bantlar varsayılan kapalı + açıklama kalıcı', (
    tester,
  ) async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Boş durum: çizelge boşu + üç boş grafik aynı metni kullanır
    // (en az bir eşleşme yeterli).
    expect(find.text('No measurements yet'), findsWidgets);

    // Bant anahtarı kapalı başlar (önce kaydırıp kurulumunu zorla).
    final toggleText = find.text(
      'Show research ranges from the article you read',
    );
    await tester.scrollUntilVisible(
      toggleText,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    final toggle = tester.widget<SwitchListTile>(
      find.ancestor(of: toggleText, matching: find.byType(SwitchListTile)),
    );
    expect(toggle.value, isFalse);

    // Kalıcı açıklama metni bantlar kapalıyken de GKI grafiğinin altında
    // kurulur (§6.4).
    final disclaimer = find.textContaining('not clinical normal ranges');
    await tester.scrollUntilVisible(
      disclaimer,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(disclaimer, findsOneWidget);
  });

  testWidgets('bant anahtarını açınca değer değişir; açıklama kalır', (
    tester,
  ) async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));
    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    final toggleText = find.text(
      'Show research ranges from the article you read',
    );
    await tester.scrollUntilVisible(
      toggleText,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(toggleText);
    await tester.pumpAndSettle();

    final toggle = tester.widget<SwitchListTile>(
      find.ancestor(of: toggleText, matching: find.byType(SwitchListTile)),
    );
    expect(toggle.value, isTrue);
    expect(find.textContaining('not clinical normal ranges'), findsOneWidget);
  });

  testWidgets('kayıtlı oturum çizelgede GKI değeriyle görünür', (tester) async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => gracefulTeardown(tester));

    // Önce veriyi yaz, sonra UI'yı kur (timelineProvider ilk izlemede
    // okur). 90/18 = 5,0 ÷ 2,5 = 2,0.
    final glucoseId = await db
        .into(db.glucoseMeasurement)
        .insert(
          GlucoseMeasurementCompanion.insert(
            rawValue: 90,
            rawUnit: 'mg_dL',
            mmolL: 5.0,
            measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
            localOffsetMinutes: 180,
            sourceType: 'fingerstick',
          ),
        );
    final ketoneId = await db
        .into(db.ketoneMeasurement)
        .insert(
          KetoneMeasurementCompanion.insert(
            rawValue: 2.5,
            mmolL: 2.5,
            measuredAtUtc: DateTime.utc(2026, 9, 20, 8),
            localOffsetMinutes: 180,
          ),
        );
    await db
        .into(db.measurementSession)
        .insert(
          MeasurementSessionCompanion.insert(
            glucoseId: Value(glucoseId),
            ketoneId: Value(ketoneId),
            gkiValue: 2.0,
            formulaVersion: 'gki-v1',
            matchKind: 'simultaneous',
            confirmedByUser: true,
            computedAtUtc: DateTime.utc(2026, 9, 20, 8),
          ),
        );

    await tester.pumpWidget(scope());
    await tester.pumpAndSettle();

    // Çizelge grafiklerin altında — kaydırınca kurulur.
    final entryCard = find.text('GKI 2.0');
    await tester.scrollUntilVisible(
      entryCard,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(entryCard, findsOneWidget);
    expect(find.textContaining('simultaneous'), findsOneWidget);
    // Boş durum artık yok.
    expect(find.text('No measurements yet'), findsNothing);
  });
}
