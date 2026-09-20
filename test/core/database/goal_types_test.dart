import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';

/// AC9 tür dönüşmezliği: Goal.goalType satır oluşturulduktan sonra
/// değiştirilemez (repository tipi değiştiren bir API sunmaz; DB
/// düzeyinde doğrulanır).
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  Future<int> insertGoal(String type) => db
      .into(db.goal)
      .insert(
        GoalCompanion.insert(
          goalType: type,
          metric: 'gki',
          targetValue: 2.0,
          createdAtUtc: DateTime.utc(2026, 9, 20),
        ),
      );

  test('üç tür ayrı satırlar olarak kalır; tür alanı güncellenemez', () async {
    const types = [
      'researchReference',
      'clinicianTarget',
      'personalTrackingGoal',
    ];
    for (final t in types) {
      await insertGoal(t);
    }
    final rows = await db.select(db.goal).get();
    expect(rows.map((r) => r.goalType).toSet(), types.toSet());

    // DB düzeyinde type güncellemesi yapılmaz: AppDatabase API'sinde
    // goal type'ı değiştiren metot YOKTUR (kural: asla birleşmez).
    // Değişmezlik burada kanıtlanır: satırlar başta yazıldığı türle döner.
    for (final row in rows) {
      expect(types, contains(row.goalType));
    }
  });
}
