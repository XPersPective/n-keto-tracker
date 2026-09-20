import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

/// DB şifreleme anahtarının secure storage'daki anahtarı.
const _dbKeyStorageKey = 'n_keto_tracker.db.key.v1';

/// Uygulama veritabanı: tamamen cihaz içi, SQLCipher ile şifreli SQLite
/// (ADR-0001). Anahtar ilk açılışta rastgele üretilir ve platform güvenli
/// deposunda saklanır; DB dosyası düz sqlite3 ile okunamaz.
///
/// - schemaVersion 1: ilk şema. Sonraki değişiklikler ileri yönlü migration
///   + fixture'lı test ile gelir (MASTER §3.3, §13).
/// - Foreign key'ler açılışta etkinleştirilir.
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

  /// Testlerde bellek içi veritabanı (şifreleme testte ayrıca doğrulanır).
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

/// Şifreleme anahtarını üretir/okur (flutter_secure_storage).
///
/// Test ve uygulama kodu bu soyutlamayı paylaşır; depo kararı platformun
/// kendi güvenli deposundadır (keystore/keychain), koda gömülü değildir.
Future<String> loadOrCreateDatabaseKey({
  FlutterSecureStorage storage = const FlutterSecureStorage(),
}) async {
  final existing = await storage.read(key: _dbKeyStorageKey);
  if (existing != null && existing.isNotEmpty) {
    return existing;
  }
  final key = _generateKey();
  await storage.write(key: _dbKeyStorageKey, value: key);
  return key;
}

/// 32 byte rastgele → 64 hex karakter. `Random.secure` OS CSPRNG'sinden
/// beslenir; anahtar koda veya repoya asla yazılmaz.
String _generateKey() {
  final random = Random.secure();
  return List.generate(
    32,
    (_) => random.nextInt(256),
  ).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}${Platform.pathSeparator}n_keto_tracker.db');
    final key = await loadOrCreateDatabaseKey();
    return NativeDatabase(
      file,
      setup: (rawDb) {
        // SQLCipher derlemesinde key, açılışın ilk işlemi olmalıdır.
        rawDb.execute("PRAGMA key = '$key';");
      },
    );
  });
}
