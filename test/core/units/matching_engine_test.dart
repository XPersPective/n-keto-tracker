import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/units/glucose.dart';
import 'package:n_keto_tracker/core/units/matching.dart';

/// T12 eşleştirme motoru testleri — MASTER_PROMPT §6.3 ve §16.1
/// eşleştirme maddeleri: pencere içi/dışı, en küçük |Δt|, eşitlikte erken
/// zaman, ölçümün yeniden kullanılmaması.
void main() {
  DateTime utc(int month, int day, int minute) =>
      DateTime.utc(2026, month, day, 8, minute);

  MeasurementCandidate g(int id, DateTime at, {int? session}) =>
      MeasurementCandidate(
        id: id,
        kind: MeasurementKind.glucose,
        atUtc: at,
        usedInSessionId: session,
      );

  MeasurementCandidate k(int id, DateTime at, {int? session}) =>
      MeasurementCandidate(
        id: id,
        kind: MeasurementKind.ketone,
        atUtc: at,
        usedInSessionId: session,
      );

  test('pencere içi tek aday önerilir; fark saklanır', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0))],
      ketones: [k(2, utc(9, 1, 4))],
    );
    expect(pair, isNotNull);
    expect(pair!.glucose.id, 1);
    expect(pair.ketone.id, 2);
    expect(pair.differenceMinutes, 4);
  });

  test('pencere dışı otomatik eşleşme yok (null)', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0))],
      ketones: [k(2, utc(9, 1, 6))],
    );
    expect(pair, isNull);
  });

  test('en küçük |Δt| kazanır', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0))],
      ketones: [k(2, utc(9, 1, 5)), k(3, utc(9, 1, 2))],
    );
    expect(pair!.ketone.id, 3);
    expect(pair.differenceMinutes, 2);
  });

  test('eşitlikte daha erken zaman damgası kazanır', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 10))],
      ketones: [k(2, utc(9, 1, 5)), k(3, utc(9, 1, 15))], // ikisi de |Δt|=5
    );
    expect(pair!.ketone.id, 2); // 08:05 < 08:15
    expect(pair.differenceMinutes, 5);
  });

  test('başka oturumda kullanılmış ölçüm önerilmez', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0)), g(4, utc(9, 1, 20))],
      ketones: [k(2, utc(9, 1, 1), session: 99)],
    );
    // 2 kullanılmış → 1 ile eşleşemez; 4 pencere dışında.
    expect(pair, isNull);
  });

  test('kullanılabilir ikinci çift seçilir', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0), session: 98), g(4, utc(9, 1, 20))],
      ketones: [k(2, utc(9, 1, 21))],
    );
    expect(pair!.glucose.id, 4);
    expect(pair.differenceMinutes, 1);
  });

  test('pencere sınırı 1–15 ile sıkıştırılır (clamp)', () {
    final pair = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0))],
      ketones: [k(2, utc(9, 1, 5))],
      windowMinutes: 60, // >15 → 15'e çekilir; 5 dk yine pencere içinde
    );
    expect(pair, isNotNull);
    final outside = MatchingEngine.suggestPair(
      glucoses: [g(1, utc(9, 1, 0))],
      ketones: [k(2, utc(9, 1, 20))],
      windowMinutes: 3,
    );
    expect(outside, isNull);
  });

  test('oturum hesapları formül sürümlü GKI üretir; eşzamanlı=aynı hesap', () {
    final glucose = GlucoseValue.fromRaw(90, GlucoseUnit.mgDl);
    final a = MatchingEngine.simultaneousSession(
      glucose: glucose,
      bhbMmolL: 2.5,
    );
    final b = MatchingEngine.approximateMatch(glucose: glucose, bhbMmolL: 2.5);
    expect(a.value, 2.0);
    expect(b.value, 2.0);
    expect(a.formulaVersion, b.formulaVersion);
  });
}
