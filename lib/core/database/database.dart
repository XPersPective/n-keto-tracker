import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

/// Uygulama veritabanı: tamamen cihaz içi SQLite (Drift).
///
/// - schemaVersion 1: ilk şema. Bundan sonraki her değişiklik ileri yönlü
///   migration + fixture'lı test ile gelir (MASTER §3.3, §13).
/// - Foreign key'ler açılışta etkinleştirilir.
/// - Şifreleme kararı T8/ADR'de; uygulanana kadar şifresiz SQLite'tır ve
///   kullanıcı metinleri bunu söyler (MASTER §14.2 — yanlış iddia yok).
@DriftDatabase(
  tables: [
    AppSettings,
    ConsentRecords,
    UserProfile,
    RiskScreening,
    EnergyEstimate,
    Goal,
    Food,
    ServingOption,
    Recipe,
    RecipeIngredient,
    Meal,
    MealItem,
    GlucoseMeasurement,
    KetoneMeasurement,
    MeasurementSession,
    WeightEntry,
    SymptomDefinition,
    SymptomEntry,
    ContextTag,
    MealPlan,
    MealPlanEntry,
    ShoppingList,
    ShoppingListItem,
    EvidenceSource,
    EvidenceClaim,
    ContentVersion,
    ExportHistory,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Testlerde bellek içi veritabanı.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}${Platform.pathSeparator}n_keto_tracker.db');
    return NativeDatabase(file);
  });
}
