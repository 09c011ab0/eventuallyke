import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../events/providers/event_providers.dart';
import '../providers/favorites_providers.dart';
import '../../events/widgets/event_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesIdsProvider);
    final allEvents = ref.watch(eventServiceProvider).getAll();
    final saved = allEvents.where((e) => favorites.contains(e.id)).toList();

    if (saved.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Saved')),
        body: const Center(
          child: Text('Your saved events will appear here.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: saved.length,
        itemBuilder: (context, index) {
          final event = saved[index];
          return EventCard(
            event: event,
            onTap: () => context.push('/event/${event.id}'),
          );
        },
      ),
    );
  }
}
