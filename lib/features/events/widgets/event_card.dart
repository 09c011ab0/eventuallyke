import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../favorites/providers/favorites_providers.dart';

import '../models/event.dart';

class EventCard extends ConsumerWidget {
  const EventCard({super.key, required this.event, this.onTap});

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favoritesIdsProvider.select((ids) => ids.contains(event.id)));
    final dateStr = DateFormat('EEE, MMM d • h:mm a').format(event.start);
    final priceStr = event.isFree
        ? 'Free'
        : (event.price != null ? 'KES ${event.price}' : '');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: event.coverImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(event.category.toUpperCase()),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.place, size: 16, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(event.city, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      if (event.rating != null)
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                            Text(event.rating!.toStringAsFixed(1)),
                          ],
                        ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => ref.read(favoritesIdsProvider.notifier).toggle(event.id),
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text('$dateStr • ${event.locationName}'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (priceStr.isNotEmpty)
                        Text(priceStr, style: const TextStyle(fontWeight: FontWeight.w700)),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.event_available),
                        label: const Text('Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}