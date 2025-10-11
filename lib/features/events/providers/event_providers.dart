import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event.dart';
import '../services/event_service.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  return EventService();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCityProvider = StateProvider<String?>((ref) => null);

final filteredEventsProvider = Provider<List<Event>>((ref) {
  final service = ref.watch(eventServiceProvider);
  final query = ref.watch(searchQueryProvider);
  final city = ref.watch(selectedCityProvider);
  return service.search(query: query, city: city);
});

final trendingEventsProvider = Provider<List<Event>>((ref) {
  return ref.watch(eventServiceProvider).trending();
});

final eventByIdProvider = Provider.family<Event?, String>((ref, id) {
  return ref.watch(eventServiceProvider).getById(id);
});

final availableCitiesProvider = Provider<List<String>>((ref) {
  final all = ref.watch(eventServiceProvider).getAll();
  final cities = {...all.map((e) => e.city)}.toList()..sort();
  return cities;
});