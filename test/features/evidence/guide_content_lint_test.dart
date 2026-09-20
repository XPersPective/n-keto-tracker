import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// T17 içerik lint testleri (MASTER_PROMPT §9, §16.5): rehber içeriğinde
/// ahlaki/korkutucu/kesin yargı dili yok; üç grup eksiksiz; kanıt
/// etiketi E6.
void main() {
  final guide = File('assets/seed/food_guide.json').readAsStringSync();
  final doc = jsonDecode(guide) as Map<String, dynamic>;
  final cards = (doc['cards'] as List).cast<Map<String, dynamic>>();

  // Yasaklı dil listesi: korkutucu/kesin yargı/ahlaki kategori (TR+EN).
  const banned = [
    'zehir',
    'zehirli',
    'mucize',
    'kesinlikle yasak',
    'asla yemeyin',
    'tehlikeli',
    'zararlı',
    'toksin',
    'sağlıksız gıda',
    'düşman',
    'poison',
    'toxic',
    'miracle',
    'strictly forbidden',
    'never eat',
    'dangerous',
    'harmful',
    'unhealthy food',
    'enemy',
    'evil',
  ];

  test('üç grup eksiksiz (prefer/limit/avoid)', () {
    final groups = cards.map((c) => c['group']).toSet();
    expect(groups, containsAll(['prefer', 'limit', 'avoid']));
  });

  test('her kart kanıt etiketi E6 ve dilli Neden? taşıyor', () {
    for (final c in cards) {
      expect(c['evidenceLevel'], 'E6', reason: '${c['id']}: E6 olmalı');
      expect(
        (c['reasonTr'] as String).trim(),
        isNotEmpty,
        reason: '${c['id']}: reasonTr boş',
      );
      expect(
        (c['reasonEn'] as String).trim(),
        isNotEmpty,
        reason: '${c['id']}: reasonEn boş',
      );
      expect(
        (c['alternativesTr'] as String).trim(),
        isNotEmpty,
        reason: '${c['id']}: alternatifler boş',
      );
    }
  });

  test('yasaklı kesin yargı dili içeriğe sızmamış (TR/EN)', () {
    final violations = <String>[];
    for (final c in cards) {
      final text = [
        c['reasonTr'],
        c['reasonEn'],
        c['alternativesTr'],
        c['alternativesEn'],
      ].join(' ').toLowerCase();
      for (final word in banned) {
        if (text.contains(word)) {
          violations.add('${c['id']}: "$word"');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('; '));
  });

  test('ARB kullanıcı metinlerinde de yasaklı dil yok (TR/EN)', () {
    for (final path in ['lib/app/l10n/app_en.arb', 'lib/app/l10n/app_tr.arb']) {
      final arb = File(path).readAsStringSync().toLowerCase();
      for (final word in banned) {
        // '@' meta açıklamaları hariç içerik anahtarlarında arar.
        expect(
          arb.contains(word),
          isFalse,
          reason: '$path yasaklı kelime içeriyor: "$word"',
        );
      }
    }
  });
}
