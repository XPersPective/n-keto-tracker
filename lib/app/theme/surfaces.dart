import 'package:flutter/material.dart';

/// Marka gradyanlı üst kart (Bugün ekranı vb.).
class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF0F3D38), Color(0xFF14524A)]
              : const [Color(0xFF0B6E64), Color(0xFF16947F)],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: IconTheme.merge(
          data: const IconThemeData(color: Colors.white),
          child: child,
        ),
      ),
    );
  }
}

/// Bölüm kartı: başlık + içerik, ince kenarlıklı düz yüzey.
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

/// Boş durum (empty state) + eylem düğmesi (PB-031).
///
/// Kullanıcı dostuluğu kuralı: bir bölüm boşsa kullanıcı **ne yapacağını**
/// görmelidir; sadece "henüz kayıt yok" metni ölü bir uç noktadır.
/// Bu bileşen her boş durumda bir eylem sunar.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.inbox_outlined,
  });

  final String message;

  /// Eylem düğmesi metni; null ise düğme gösterilmez.
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = actionLabel;
    final onTap = onAction;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: scheme.outline),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
          if (label != null && onTap != null) ...[
            const SizedBox(height: 12),
            // Dokunma hedefi ≥48 px (PB-031 kabul ölçütü).
            FilledButton.tonalIcon(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 48),
                padding: const EdgeInsets.symmetric(horizontal: 18),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: Text(label),
            ),
          ],
        ],
      ),
    );
  }
}
