import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/database/database.dart';
import 'core/database/evidence_seeder.dart';
import 'core/database/food_seeder.dart';
import 'core/database/providers.dart';
import 'core/database/recipe_seeder.dart';

/// Üretim veritabanını hazırlar: şifreli AppDatabase + gömülü içerik
/// (besin/tarif/kanıt tohumu). Tohumlayıcılar idempotenttir; ilk açılışta
/// tabloları doldurur, sonraki açılışlarda atlar. Tohumlama başarısız
/// olsa bile uygulama açılır (ölçüm kaydı içerikten bağımsızdır) ve
/// bir sonraki açılış yeniden dener.
Future<void> _seedContent(AppDatabase db) async {
  try {
    await FoodSeeder(db).seedFromAssets();
    await RecipeSeeder(db).seedFromAssets();
    await EvidenceSeeder(db).seedFromAssets();
  } catch (_) {
    // Tohumlama içerik dosyalarına bağlıdır; ölçüm/öğün kaydı
    // çalışmaya devam eder. Bir sonraki açılışta yeniden denenir.
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Besin fotoğrafları Wikimedia Commons'tan açık lisansla alındı; atıflar
  // (yazar, lisans, kaynak) Flutter'ın lisans sayfasında gösterilir (CC BY).
  LicenseRegistry.addLicense(() async* {
    final credits = await rootBundle.loadString(
      'assets/food_images/CREDITS.md',
    );
    yield LicenseEntryWithLineBreaks([
      'Food photos (Wikimedia Commons)',
    ], credits);
  });
  final db = AppDatabase();
  await _seedContent(db);
  runApp(
    ProviderScope(
      // Üretim veritabanı bağlantısı (PB-010): şifreli AppDatabase; anahtar
      // loadOrCreateDatabaseKey ile açılışta secure storage'dan gelir.
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const NKetoApp(),
    ),
  );
}
