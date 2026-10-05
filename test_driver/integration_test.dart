import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Mağaza ekran görüntülerini ana makineye yazar (SHOT_DIR, varsayılan build/shots).
Future<void> main() => integrationDriver(
  onScreenshot: (name, bytes, [args]) async {
    final dir = Platform.environment['SHOT_DIR'] ?? 'build/shots';
    final file = File('$dir/$name.png');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    return true;
  },
);
