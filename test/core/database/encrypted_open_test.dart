import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n_keto_tracker/core/database/database.dart';
import 'package:sqlite3/sqlite3.dart' as plain;

/// T8 doğrulamaları (ADR-0001): anahtar üretimi/saklama ve şifreli dosyanın
/// düz sqlite3 ile açılamaması.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // flutter_secure_storage'ın testdeki platform kanalını sahteleyen basit
  // bellek içi uygulama.
  final fakeStorage = <String, String>{};
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async {
        final args = Map<String, Object?>.from(call.arguments as Map? ?? {});
        final key = args['key'] as String?;
        switch (call.method) {
          case 'read':
            return fakeStorage[key];
          case 'write':
            fakeStorage[key!] = args['value'] as String;
            return null;
          case 'delete':
            fakeStorage.remove(key);
            return null;
          case 'deleteAll':
            fakeStorage.clear();
            return null;
          default:
            return null;
        }
      });

  test('anahtar üretilir ve secure storage\'da saklanır', () async {
    const storage = FlutterSecureStorage();
    final key1 = await loadOrCreateDatabaseKey(storage: storage);
    expect(key1.length, 64, reason: '32 byte = 64 hex');

    // İkinci çağrı aynı anahtarı döner (üretim bir kez).
    final key2 = await loadOrCreateDatabaseKey(storage: storage);
    expect(key2, key1);
    expect(fakeStorage.containsKey('n_keto_tracker.db.key.v1'), isTrue);
  });

  test('anahtar rastgeledir: farklı depo farklı anahtar üretir', () async {
    final a = await loadOrCreateDatabaseKey(
      storage: const FlutterSecureStorage(),
    );
    fakeStorage.clear();
    final b = await loadOrCreateDatabaseKey(
      storage: const FlutterSecureStorage(),
    );
    expect(a, isNot(b));
  });

  test('SQLCipher ile açılan DB dosyası düz sqlite3 ile AÇILAMAZ', () async {
    final tmp = await Directory.systemTemp.createTemp('nketo_enc');
    final path = '${tmp.path}${Platform.pathSeparator}enc.db';
    addTearDown(() => tmp.delete(recursive: true));

    final key = await loadOrCreateDatabaseKey(
      storage: const FlutterSecureStorage(),
    );

    // Şifreli DB oluştur ve bir satır yaz.
    final raw = plain.sqlite3.open(path);
    raw.execute("PRAGMA key = '$key';");
    raw.execute('CREATE TABLE t (v INTEGER);');
    raw.execute('INSERT INTO t VALUES (42);');
    raw.close();

    // Düz sqlite3 (anahtarsız) açmayı dene → SqliteException(code 26,
    // "file is not a database") BEKLENEN davranıştır: dosya gerçekten
    // şifrelidir. Windows'ta dispose sonrası dosya kilitli kalabildiği
    // için temp klasörü silinemezse sessizce geçilir.
    final plainDb = plain.sqlite3.open(path);
    expect(
      () => plainDb.select('SELECT count(*) AS n FROM sqlite_master;'),
      throwsA(
        isA<plain.SqliteException>().having(
          (e) => e.extendedResultCode,
          'extendedResultCode',
          26,
        ),
      ),
      reason: 'Şifresiz açılış dosyayı tanıyamamalı (code 26)',
    );
    plainDb.close();

    // Anahtarla tekrar aç → veri okunur (gerçek şifreleme kanıtı).
    final reopened = plain.sqlite3.open(path);
    reopened.execute("PRAGMA key = '$key';");
    final v = reopened.select('SELECT v FROM t;').first['v'] as int;
    reopened.close();
    expect(v, 42);
  });

  test('Drift NativeDatabase setup PRAGMA key ile şifreli DB açar', () async {
    final tmp = await Directory.systemTemp.createTemp('nketo_drift');
    final path = '${tmp.path}${Platform.pathSeparator}enc2.db';
    addTearDown(() => tmp.delete(recursive: true));

    final key = await loadOrCreateDatabaseKey(
      storage: const FlutterSecureStorage(),
    );
    final db = AppDatabase.forTesting(
      NativeDatabase(
        File(path),
        setup: (raw) => raw.execute("PRAGMA key = '$key';"),
      ),
    );
    // Basit yazma/okuma: şema oluşturulabiliyor (şifreli dosyada).
    await db
        .into(db.contextTag)
        .insert(
          ContextTagCompanion.insert(
            id: 'fasting',
            labelTr: 'Açlık',
            labelEn: 'Fasting',
          ),
        );
    final rows = await db.select(db.contextTag).get();
    expect(rows.single.id, 'fasting');
    await db.close();
  });
}
