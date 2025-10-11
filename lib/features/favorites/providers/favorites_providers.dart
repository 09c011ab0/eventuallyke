import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesIdsProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier(ref);
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this.ref) : super({}) {
    _load();
  }

  final Ref ref;
  static const _prefsKey = 'favorites_event_ids_v1';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      final list = (jsonDecode(raw) as List).cast<String>();
      state = {...list};
    }
  }

  Future<void> toggle(String eventId) async {
    final next = {...state};
    if (next.contains(eventId)) {
      next.remove(eventId);
    } else {
      next.add(eventId);
    }
    state = next;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(state.toList()));
  }

  bool isFavorite(String eventId) => state.contains(eventId);
}
