import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';

/// Ana veritabanı sağlayıcısı: uygulama başlangıcında şifreli
/// [AppDatabase] örneğiyle override edilir; testlerde bellek içi örnek.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'appDatabaseProvider uygulama başlangıcında override edilmelidir',
  );
});
