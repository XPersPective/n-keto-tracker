import 'package:flutter/material.dart';

/// Besin kategorisi → özgün vektör ikon eşlemesi (PB-030).
///
/// Neden ikon, neden fotoğraf değil:
/// - Uygulama tamamen çevrimdışı (C-001); fotoğraf paketi APK boyutunu
///   ciddi biçimde büyütür ve besin başına ayrı lisans + doğrulama
///   gerektirir.
/// - Kategori ikonu **fotoğraf iddiası taşımaz**, bu yüzden kullanıcıyı
///   yanıltmaz (2026-10-13 talimatı).
/// - Emoji metni KULLANILMAZ: glyph cihazdan cihaza değişir ve tutarsız
///   görünür. Yalnız Material `IconData` kullanılır.
///
/// Kategori değerleri `assets/seed/foods.json` ve `Food.category`
/// sütunundaki 15 değerle birebir eşleşir. Bilinmeyen kategori için
/// [foodIconFor] güvenli bir varsayılan döner — çağıran taraf null
/// kontrolü yapmak zorunda kalmaz.
abstract final class FoodIcons {
  /// Kategori kodu → ikon.
  static const Map<String, IconData> byCategory = <String, IconData>{
    'meat': Icons.restaurant,
    'poultry': Icons.egg_alt_outlined,
    'fish': Icons.set_meal,
    'dairy': Icons.water_drop_outlined,
    'fats': Icons.opacity,
    'nuts': Icons.scatter_plot_outlined,
    'vegetable': Icons.eco_outlined,
    'fruit': Icons.apple,
    'legume': Icons.grain,
    'grain': Icons.bakery_dining,
    'tuber': Icons.circle_outlined,
    'beverage': Icons.local_cafe_outlined,
    'sweet': Icons.cake_outlined,
    'snack': Icons.cookie_outlined,
    'prepared': Icons.lunch_dining_outlined,
  };

  /// Kategori kodu için ikon döner; bilinmeyen kodda genel yemek ikonu.
  static IconData foodIconFor(String? category) {
    if (category == null) return Icons.restaurant_menu;
    return byCategory[category] ?? Icons.restaurant_menu;
  }
}

/// Kategori rozeti: renkli daire içinde ikon.
///
/// Besin satırlarında, tarif kartlarında ve plan öğelerinde aynı bileşen
/// kullanılır; böylece ikon dili uygulama genelinde tutarlı kalır.
class FoodIconBadge extends StatelessWidget {
  const FoodIconBadge({super.key, required this.category, this.size = 32});

  final String? category;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        FoodIcons.foodIconFor(category),
        size: size * 0.55,
        color: scheme.onPrimaryContainer,
      ),
    );
  }
}
