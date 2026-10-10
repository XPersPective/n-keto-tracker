import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/database/providers.dart';
import '../../core/units/walking_plan.dart';

/// Kullanıcının ilk UserProfile satırını okur (PB-025). Profil yoksa
/// null döner — sayfa varsayılan değerlerle plan üretir.
final _userProfileProvider = FutureProvider<UserProfileRow?>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.userProfile)
        ..orderBy([(p) => OrderingTerm.asc(p.id)])
        ..limit(1))
      .getSingleOrNull();
});

/// Yürüyüş planı sağlayıcısı: UserProfile + kanıt referanslarından
/// kişisel 8 haftalık plan üretir. Profil yoksa yaş=40 / sedentary
/// varsayılanı ile üretir.
final walkingPlanProvider = Provider.autoDispose<WalkingPlan>((ref) {
  // _userProfileProvider'dan okumak burada async gerektirir; senkron
  // erişim için .asData?.value ile çağırıyoruz. UI tarafı FutureProvider
  // üzerinden bekliyor; plan ilk frame'de default olabilir.
  final profile = ref.read(_userProfileProvider).asData?.value;
  return buildWalkingPlan(
    birthYear: profile?.birthYear,
    heightCm: profile?.heightCm,
    currentWeightKg: profile?.currentWeightKg,
    activityLevel: profile?.activityLevel ?? 'sedentary',
    intensityWeekOverride: null,
  );
});

/// Plan içindeki kanıt referanslarını DB'den getirir.
final walkingEvidenceProvider =
    FutureProvider.autoDispose<List<EvidenceSourceRow>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final plan = ref.watch(walkingPlanProvider);
  if (plan.references.isEmpty) return const [];
  final query = db.select(db.evidenceSource)
    ..where((s) => s.id.isIn(plan.references));
  query.orderBy([(s) => OrderingTerm.asc(s.id)]);
  return query.get();
});
