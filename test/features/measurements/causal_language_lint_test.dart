import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';


/// T18 nedensel dil lint'i (MASTER_PROMPT §8.3): öğün-ölçüm ilişkisi
/// yalnızca zamansal anlatılabilir; nedensellik iddiası içeren ifadeler
/// ARB'ye sızmaz.
void main() {
  // Nedensellik iddiası kelimeleri (geçmiş zaman kesin hüküm).
  const causalWords = [
    'bozdu',
    'bozar',
    'yükseltti',
    'düşürdü',
    'neden oldu',
    'etkiledi',
    'artırdı',
    'azalttı',
    'sebebi',
    'nedeniyle oldu',
    'ruined',
    'caused',
    'spiked',
    'raised my',
    'lowered my',
    'because of the meal',
    'due to the meal',
    'effected',
  ];

  test('ARB dosyalarında nedensel ilişki dili yok', () {
    for (final path in ['lib/app/l10n/app_en.arb', 'lib/app/l10n/app_tr.arb']) {
      final arb = File(path).readAsStringSync().toLowerCase();
      final hits = causalWords.where(arb.contains).toList();
      expect(hits, isEmpty, reason: '$path: $hits');
    }
  });

  test('ilişki motoru kaynak dosyasında nedensel dil yok', () {
    final source = File('lib/core/units/meal_measurement_relation.dart')
        .readAsStringSync()
        .toLowerCase();
    for (final word in causalWords) {
      expect(
        source.contains(word),
        isFalse,
        reason: 'ilişki modülü nedensel kelime içeriyor: $word',
      );
    }
  });

  test('ilişki modülü zaman çerçeveli dili zorunlu kılar', () {
    // Modülün dokümanı 'zamansal' ilkesini içerir (dil kuralı).
    final source = File('lib/core/units/meal_measurement_relation.dart')
        .readAsStringSync();
    expect(source.contains('ZAMANSAL'), isTrue);
  });

  test('json seed içeriklerinde nedensel dil yok', () {
    for (final path in [
      'assets/seed/foods.json',
      'assets/seed/food_guide.json',
    ]) {
      final content = jsonDecode(File(path).readAsStringSync())
          .toString()
          .toLowerCase();
      final hits = causalWords.where(content.contains).toList();
      expect(hits, isEmpty, reason: '$path: $hits');
    }
  });
}
