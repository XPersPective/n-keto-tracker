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
}
