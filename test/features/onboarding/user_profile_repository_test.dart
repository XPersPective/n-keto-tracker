import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';
import 'package:n_keto_tracker/core/database/user_profile_repository.dart';
import 'package:n_keto_tracker/features/onboarding/onboarding_controller.dart';

/// PB-025: Onboarding sonunda UserProfile satırı doğru alanlarla
/// yazılır; skip edilen alanlar null olur; ikinci çağrı mevcut satırı
/// günceller.
void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  test('ilk onboarding: 1990/175/80 + male2025 → UserProfile satırı', () async {
    final repo = UserProfileRepository(db);
    await repo.saveFromOnboarding(
      const OnboardingState(
        languageCode: 'tr',
        birthYear: 1990,
        heightCm: 175,
        weightKg: 80,
        energyCoefficient: EnergyCoefficient.male2025,
        consentAccepted: true,
      ),
    );
    final rows = await db.select(db.userProfile).get();
    expect(rows, hasLength(1));
    final row = rows.single;
    expect(row.birthYear, 1990);
    expect(row.heightCm, 175);
    expect(row.currentWeightKg, 80);
    expect(row.energyCoefficient, 'male2025');
    expect(row.createdAtUtc, isNotNull);
    expect(row.updatedAtUtc, isNotNull);
  });

  test('enerji katsayısı atlandı → null yazılır', () async {
    final repo = UserProfileRepository(db);
    await repo.saveFromOnboarding(
      const OnboardingState(
        languageCode: 'tr',
        birthYear: 1985,
        heightCm: 165,
        weightKg: 70,
        energyCoefficient: EnergyCoefficient.skipped,
        consentAccepted: true,
      ),
    );
    final row = (await db.select(db.userProfile).get()).single;
    expect(row.energyCoefficient, isNull);
  });

  test('alanlar skip edildi → hepsi null', () async {
    final repo = UserProfileRepository(db);
    await repo.saveFromOnboarding(const OnboardingState(consentAccepted: true));
    final row = (await db.select(db.userProfile).get()).single;
    expect(row.birthYear, isNull);
    expect(row.heightCm, isNull);
    expect(row.currentWeightKg, isNull);
    expect(row.energyCoefficient, isNull);
  });

  test(
    'ikinci çağrı: mevcut satır güncellenir (yeni satır eklenmez)',
    () async {
      final repo = UserProfileRepository(db);
      await repo.saveFromOnboarding(
        const OnboardingState(
          birthYear: 1990,
          heightCm: 175,
          weightKg: 80,
          energyCoefficient: EnergyCoefficient.male2025,
        ),
      );
      await repo.saveFromOnboarding(
        const OnboardingState(
          birthYear: 1992,
          heightCm: 178,
          weightKg: 82,
          energyCoefficient: EnergyCoefficient.female161,
        ),
      );
      final rows = await db.select(db.userProfile).get();
      expect(rows, hasLength(1));
      final row = rows.single;
      expect(row.birthYear, 1992);
      expect(row.heightCm, 178);
      expect(row.currentWeightKg, 82);
      expect(row.energyCoefficient, 'female161');
    },
  );
}
