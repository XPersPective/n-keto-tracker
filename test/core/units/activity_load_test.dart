import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/activity_load.dart';

/// DSÖ 2020 aerobik eşdeğeri: koşu iki kat, yürüyüş/diğer bir kat, kuvvet 0.
void main() {
  test('koşu dakikası iki kat, yürüyüş bir kat, kuvvet sayılmaz', () {
    expect(aerobicEquivalentMinutes(kind: 'run', durationMinutes: 30), 60);
    expect(aerobicEquivalentMinutes(kind: 'walk', durationMinutes: 30), 30);
    expect(aerobicEquivalentMinutes(kind: 'other', durationMinutes: 30), 30);
    expect(aerobicEquivalentMinutes(kind: 'strength', durationMinutes: 30), 0);
    expect(
      aerobicEquivalentMinutes(kind: 'bilinmeyen', durationMinutes: 30),
      0,
    );
  });

  test('haftalık toplam: 20 dk koşu + 60 dk yürüyüş + 40 dk kuvvet = 100', () {
    final total = totalAerobicMinutes([
      (kind: 'run', durationMinutes: 20),
      (kind: 'walk', durationMinutes: 60),
      (kind: 'strength', durationMinutes: 40),
    ]);
    expect(total, 100);
    expect(weeklyAerobicTargetMinutes, 150);
  });
}
