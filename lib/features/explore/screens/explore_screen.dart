import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../events/providers/event_providers.dart';
import '../../events/widgets/event_card.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(filteredEventsProvider);
    final cities = ref.watch(availableCitiesProvider);
    final selectedCity = ref.watch(selectedCityProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text('Explore Events'),
          actions: [
            PopupMenuButton<String?>(
              initialValue: selectedCity,
              itemBuilder: (context) => [
                const PopupMenuItem(value: null, child: Text('All Kenya')),
                ...cities.map((c) => PopupMenuItem(value: c, child: Text(c))),
              ],
              onSelected: (value) => ref.read(selectedCityProvider.notifier).state = value,
              icon: const Icon(Icons.place),
              tooltip: 'Filter by city',
            ),
            IconButton(
              onPressed: () async {
                final query = await showSearch<String?>(
                  context: context,
                  delegate: _EventSearchDelegate(initialQuery: ref.read(searchQueryProvider)),
                );
                if (query != null) {
                  ref.read(searchQueryProvider.notifier).state = query;
                }
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverList.builder(
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                onTap: () => context.push('/event/${event.id}'),
              );
            },
            itemCount: events.length,
          ),
        ),
      ],
    );
  }
}

class _EventSearchDelegate extends SearchDelegate<String?> {
  _EventSearchDelegate({String? initialQuery}) {
    query = initialQuery ?? '';
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () => close(context, query),
        child: const Text('Apply search'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
