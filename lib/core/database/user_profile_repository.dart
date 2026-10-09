import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/onboarding_controller.dart';
import 'database.dart';
import 'providers.dart';

/// Kullanıcı profili (boy/kilo/yıl/enerji katsayısı) deposu
/// (MASTER_PROMPT §4 adım 5–6; T21). Onboarding bitişinde tek satır
/// yazılır; sonraki onboarding akışlarında güncellenir.
///
/// `energyCoefficient` depoya `EnergyCoefficient.name` olarak yazılır
/// (örn. 'male2025', 'female161', 'skipped') — serbest metin değil,
/// denklemin iki doğrulanmış katsayısından biri (MASTER §4.6).
class UserProfileRepository {
  UserProfileRepository(this._db);

  final AppDatabase _db;

  /// Onboarding state'inden profil satırını upsert eder. Tüm alanlar
  /// nullable; skip edilenler null olarak saklanır.
  Future<void> saveFromOnboarding(OnboardingState state) async {
    final now = DateTime.now().toUtc();
    final energyValue = state.energyCoefficient == EnergyCoefficient.skipped
        ? null
        : state.energyCoefficient.name;
    final existing = await (_db.select(
      _db.userProfile,
    )..orderBy([(p) => OrderingTerm.asc(p.id)])..limit(1)).getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.userProfile).insert(
            UserProfileCompanion.insert(
              birthYear: Value(state.birthYear),
              heightCm: Value(state.heightCm),
              currentWeightKg: Value(state.weightKg),
              energyCoefficient: Value(energyValue),
              createdAtUtc: now,
              updatedAtUtc: now,
            ),
          );
      return;
    }
    await (_db.update(_db.userProfile)..where((p) => p.id.equals(existing.id)))
        .write(
      UserProfileCompanion(
        birthYear: Value(state.birthYear),
        heightCm: Value(state.heightCm),
        currentWeightKg: Value(state.weightKg),
        energyCoefficient: Value(energyValue),
        updatedAtUtc: Value(now),
      ),
    );
  }
}

final userProfileRepositoryProvider = Provider<UserProfileRepository>(
  (ref) => UserProfileRepository(ref.watch(appDatabaseProvider)),
);
