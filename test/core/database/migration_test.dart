import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n_keto_tracker/core/database/database.dart';

/// T30/§16.2: migration/import kanıtları (PB-004). Yayın öncesi tek şema
/// sürümü vardır (v1); geçişler ancak ikinci sürümle test edilir. Bu test
/// v1 için yapılabilecek en güçlü doğrulamayı kanıtlar:
/// - diskteki dosyada kapat→yeniden aç: veri korunur + integrity_check OK
void main() {
  test(
    'DB dosyası: kapat→yeniden aç → veri korunur + integrity_check',
    () async {
      final tmp = await Directory.systemTemp.createTemp('nketo_mig');
      final path = '${tmp.path}/persist.db';

      // Birinci açılış: veri yaz.
      final db1 = AppDatabase.forTesting(NativeDatabase(File(path)));
      await db1
          .into(db1.contextTag)
          .insert(
            ContextTagCompanion.insert(
              id: 'fasting',
              labelTr: 'Açlık',
              labelEn: 'Fasting',
            ),
          );
      await db1.close();

      // İkinci açılış: veri korunmuş olmalı.
      final db2 = AppDatabase.forTesting(NativeDatabase(File(path)));
      final rows = await db2.select(db2.contextTag).get();
      expect(rows, hasLength(1));
      expect(rows.single.id, 'fasting');

      final integrity = await db2.customSelect('PRAGMA integrity_check').get();
      expect(integrity.single.data['integrity_check'], 'ok');

      await db2.close();
      await tmp.delete(recursive: true);
    },
  );

  // v1 (1.0.0+6 üretim) → v2: yalnız hareket tablosu eklenir, veri korunur.
  test('v1 → v2: hareket tablosu eklenir, mevcut veri korunur', () async {
    final tmp = await Directory.systemTemp.createTemp('nketo_v2');
    final path = '${tmp.path}/upgrade.db';

    // v1 veritabanını taklit et: v2'de eklenen tablo yok, sürüm 1.
    final old = AppDatabase.forTesting(NativeDatabase(File(path)));
    await old
        .into(old.contextTag)
        .insert(
          ContextTagCompanion.insert(
            id: 'fasting',
            labelTr: 'Açlık',
            labelEn: 'Fasting',
          ),
        );
    await old.customStatement('DROP TABLE activity_session');
    await old.customStatement('PRAGMA user_version = 1');
    await old.close();

    final upgraded = AppDatabase.forTesting(NativeDatabase(File(path)));
    final tags = await upgraded.select(upgraded.contextTag).get();
    expect(tags.single.id, 'fasting');

    await upgraded
        .into(upgraded.activitySession)
        .insert(
          ActivitySessionCompanion.insert(
            kind: 'run',
            startedAtUtc: DateTime.utc(2026, 10, 21),
            localOffsetMinutes: 0,
            durationMinutes: 30,
            createdAtUtc: DateTime.utc(2026, 10, 21),
          ),
        );
    expect(await upgraded.select(upgraded.activitySession).get(), hasLength(1));

    final integrity = await upgraded
        .customSelect('PRAGMA integrity_check')
        .get();
    expect(integrity.single.data['integrity_check'], 'ok');

    await upgraded.close();
    await tmp.delete(recursive: true);
  });
}
