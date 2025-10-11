import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review.dart';

final _reviewsStore = StateProvider<Map<String, List<Review>>>((ref) => {});

final reviewsForEventProvider = Provider.family<List<Review>, String>((ref, eventId) {
  final map = ref.watch(_reviewsStore);
  final list = map[eventId] ?? [];
  final sorted = [...list]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return sorted;
});

final addReviewProvider = Provider((ref) {
  return (Review review) {
    final map = {...ref.read(_reviewsStore)};
    final list = [...(map[review.eventId] ?? [])]..add(review);
    map[review.eventId] = list;
    ref.read(_reviewsStore.notifier).state = map;
  };
});
