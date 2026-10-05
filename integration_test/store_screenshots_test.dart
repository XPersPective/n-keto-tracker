import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:n_keto_tracker/app/app.dart';
import 'package:n_keto_tracker/app/locale_provider.dart';
import 'package:n_keto_tracker/app/router.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/evidence_seeder.dart';
import 'package:n_keto_tracker/core/database/food_seeder.dart';
import 'package:n_keto_tracker/core/database/providers.dart';
import 'package:n_keto_tracker/core/database/recipe_seeder.dart';
import 'package:n_keto_tracker/core/monetization/premium_controller.dart';

/// Play mağazası ekran görüntüleri: her dilde, cihaz yazı tipleriyle.
///
///   flutter drive --driver=test_driver/integration_test.dart \
///     --target=integration_test/store_screenshots_test.dart -d EMULATOR_ID \
///     --dart-define=SHOT_LOCALES=tr,en
///
/// Dilden bağımsız bulucular (simge/tür) kullanır; reklam görünmesin diye
/// premium açık varsayılır. Yalnız mağaza görseli üretir, ürün davranışını
/// sınamaz.
class _PremiumOn extends PremiumController {
  @override
  PremiumState build() => const PremiumState(premium: true);
}

const _all = 'tr,en,es,pt,fr,de,it,nl,pl,ru,uk,ar,hi,id,vi,ja,ko,zh';
const _wanted = String.fromEnvironment('SHOT_LOCALES', defaultValue: _all);

/// (glukoz mg/dL, BHB mmol/L): iki hafta boyunca hafif yükselen keton.
const _series = [
  ('98', '0.6'),
  ('94', '0.9'),
  ('92', '1.2'),
  ('90', '1.5'),
  ('93', '1.4'),
  ('89', '1.9'),
  ('88', '2.3'),
  ('86', '2.8'),
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  for (final loc in _wanted.split(',')) {
    testWidgets('mağaza görüntüleri: $loc', (tester) async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      await FoodSeeder(db).seedFromAssets();
      await RecipeSeeder(db).seedFromAssets();
      await EvidenceSeeder(db).seedFromAssets();
      addTearDown(db.close);

      Widget app(ThemeMode mode) => ProviderScope(
        key: ValueKey(mode),
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          premiumProvider.overrideWith(_PremiumOn.new),
          appThemeModeProvider.overrideWithValue(mode),
        ],
        child: NKetoApp(localeOverride: Locale(loc)),
      );

      // Ana makine, logcat'te SHOTREADY satırını görünce `adb screencap` alır
      // (flutter drive'ın ekran görüntüsü kanalı Android'de güvenilir değil).
      Future<void> shot(String name) async {
        await tester.pumpAndSettle(const Duration(milliseconds: 400));
        // ignore: avoid_print
        print('SHOTREADY $loc/$name');
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 3500)),
        );
      }

      Future<void> tapNav(int index) async {
        final dest = find.byType(NavigationDestination);
        await tester.tap(dest.at(index));
        await tester.pumpAndSettle();
      }

      appRouter.go('/onboarding');
      await tester.pumpWidget(app(ThemeMode.light));
      await tester.pumpAndSettle();

      // Onboarding: 7 × İleri → onam → bitir (dilden bağımsız).
      for (var i = 0; i < 7; i++) {
        await tester.tap(find.byType(FilledButton).last);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();

      // Ölçüm serisi (gerçek form üzerinden).
      for (final (glucose, bhb) in _series) {
        await tester.tap(find.byIcon(Icons.add_chart));
        await tester.pumpAndSettle();
        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), glucose);
        await tester.enterText(fields.at(1), bhb);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(FilledButton).last);
        await tester.pumpAndSettle();
        if (identical(_series.last, (glucose, bhb)) ||
            (glucose == _series.last.$1 && bhb == _series.last.$2)) {
          await shot('2_gki');
        }
        appRouter.pop();
        await tester.pumpAndSettle();
      }

      // Bugün (hero + hızlı eylemler)
      await tapNav(0);
      await shot('1_today');
      // Günlük (grafikler)
      await tapNav(1);
      await shot('3_log');
      // Plan: taslak üret → gün kartları
      await tapNav(2);
      await tester.tap(find.byIcon(Icons.auto_awesome));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await shot('5_plan');
      // Trendler
      await tapNav(3);
      await shot('4_trends');
      // Rehber
      await tapNav(4);
      await shot('6_guide');

      // Koyu tema: Bugün + Günlük
      await tester.pumpWidget(app(ThemeMode.dark));
      await tester.pumpAndSettle();
      await tapNav(0);
      await shot('7_today_dark');
      await tapNav(1);
      await shot('8_log_dark');
    });
  }
}
