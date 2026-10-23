import 'package:flutter/material.dart';

import 'food_icons.dart';

/// Besin ya da tarif fotoğrafı (`assets/food_images/<id>.webp`).
///
/// Fotoğraf yoksa ya da yüklenemezse kategori ikonuna düşer; boş kutu
/// gösterilmez. Fotoğraf dekoratiftir: metin zaten yanında, bu yüzden
/// ekran okuyucudan gizlenir.
class FoodPhoto extends StatelessWidget {
  const FoodPhoto({
    super.key,
    required this.id,
    this.category,
    this.size = 56,
    this.radius = 14,
  });

  final String id;
  final String? category;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          'assets/food_images/$id.webp',
          fit: BoxFit.cover,
          excludeFromSemantics: true,
          errorBuilder: (_, _, _) => Center(
            child: FoodIconBadge(category: category, size: size * 0.7),
          ),
        ),
      ),
    );
  }
}
