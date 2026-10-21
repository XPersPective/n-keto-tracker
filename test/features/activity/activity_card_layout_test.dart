import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/app/l10n/generated/app_localizations.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/features/activity/activity_card.dart';
import 'package:n_keto_tracker/features/activity/activity_view_model.dart';

/// Hareket kartı düzen testi: dar ekranda (360 dp) uzun çeviri metinleriyle
/// taşma (RenderFlex overflow) olmamalı. Taşma varsa test düşer.
void main() {
  final sessions = [
    ActivitySessionRow(
      id: 1,
      kind: 'run',
      startedAtUtc: DateTime.utc(2026, 10, 21, 5),
      localOffsetMinutes: 180,
      durationMinutes: 125,
      distanceKm: 12.5,
      note: null,
      createdAtUtc: DateTime.utc(2026, 10, 21, 5),
    ),
    ActivitySessionRow(
      id: 2,
      kind: 'strength',
      startedAtUtc: DateTime.utc(2026, 10, 21, 9),
      localOffsetMinutes: 180,
      durationMinutes: 40,
      distanceKm: null,
      note: null,
      createdAtUtc: DateTime.utc(2026, 10, 21, 9),
    ),
  ];

  for (final locale in ['tr', 'en', 'de', 'my', 'ta', 'hu', 'ka', 'zh_Hant']) {
    testWidgets('hareket kartı 360 dp genişlikte taşmaz: $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(360 * 3, 800 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final parts = locale.split('_');
      final parsed = parts.length == 2
          ? Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1])
          : Locale(locale);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todayActivityProvider.overrideWith((ref) async => sessions),
            weekActivityProvider.overrideWith((ref) async => sessions),
          ],
          child: MaterialApp(
            locale: parsed,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: ListView(
                padding: EdgeInsets.all(16),
                children: [ActivityCard()],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ActivityCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
