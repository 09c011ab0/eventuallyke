import 'dart:math' as math;

import '../models/event.dart';

class EventService {
  EventService();

  final List<Event> _events = _sampleEvents;

  List<Event> getAll() => List.unmodifiable(_events);

  List<Event> trending({int limit = 6}) {
    final sorted = [..._events]..sort((a, b) {
      final ar = (a.rating ?? 0).compareTo(b.rating ?? 0);
      if (ar != 0) return -ar; // higher rating first
      return a.start.compareTo(b.start); // then sooner events
    });
    return sorted.take(limit).toList();
  }

  List<Event> search({String? query, String? city}) {
    final q = (query ?? '').trim().toLowerCase();
    return _events.where((e) {
      final matchesQuery = q.isEmpty ||
          e.title.toLowerCase().contains(q) ||
          (e.description ?? '').toLowerCase().contains(q) ||
          e.tags.any((t) => t.toLowerCase().contains(q)) ||
          e.category.toLowerCase().contains(q);
      final matchesCity = city == null || city.isEmpty || e.city == city;
      return matchesQuery && matchesCity;
    }).toList();
  }

  List<Event> nearby({required double latitude, required double longitude, double withinKm = 50}) {
    return _events.where((e) => _distanceKm(latitude, longitude, e.latitude, e.longitude) <= withinKm).toList();
  }

  Event? getById(String id) => _events.where((e) => e.id == id).cast<Event?>().firstOrNull;
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

// Haversine distance in km
double _distanceKm(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371.0; // km
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_deg2rad(lat1)) * math.cos(_deg2rad(lat2)) *
          math.sin(dLon / 2) * math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return r * c;
}

double _deg2rad(double deg) => deg * (math.pi / 180.0);

final List<Event> _sampleEvents = [
  Event(
    id: '1',
    title: 'Nairobi Tech Meetup',
    city: 'Nairobi',
    locationName: 'iHub, Senteu Plaza',
    latitude: -1.2921,
    longitude: 36.8219,
    start: DateTime.now().add(const Duration(days: 2, hours: 18)),
    end: DateTime.now().add(const Duration(days: 2, hours: 21)),
    category: 'tech',
    coverImageUrl: 'https://images.unsplash.com/photo-1518779578993-ec3579fee39f?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_tech_001',
    price: 0,
    isFree: true,
    description: 'Monthly meetup for developers and tech enthusiasts in Nairobi.',
    tags: const ['tech', 'meetup', 'startup'],
    rating: 4.6,
  ),
  Event(
    id: '2',
    title: 'Mombasa Beach Festival',
    city: 'Mombasa',
    locationName: 'Nyali Beach',
    latitude: -4.0505,
    longitude: 39.6673,
    start: DateTime.now().add(const Duration(days: 10, hours: 12)),
    end: DateTime.now().add(const Duration(days: 10, hours: 22)),
    category: 'music',
    coverImageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_music_123',
    price: 1500,
    isFree: false,
    description: 'Sun, sand, and sounds — the best beach party in KE.',
    tags: const ['music', 'festival', 'beach'],
    rating: 4.8,
  ),
  Event(
    id: '3',
    title: 'Kisumu Cultural Night',
    city: 'Kisumu',
    locationName: 'Dunga Hill Camp',
    latitude: -0.0917,
    longitude: 34.7680,
    start: DateTime.now().add(const Duration(days: 5, hours: 17)),
    end: DateTime.now().add(const Duration(days: 5, hours: 23)),
    category: 'culture',
    coverImageUrl: 'https://images.unsplash.com/photo-1587174486073-a4f9bb7f3d9b?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_culture_77',
    price: 800,
    isFree: false,
    description: 'Experience Luo culture with music, food, and dance by the lake.',
    tags: const ['culture', 'music', 'food'],
    rating: 4.5,
  ),
  Event(
    id: '4',
    title: 'Safari Marathon',
    city: 'Nairobi',
    locationName: 'Uhuru Park',
    latitude: -1.2921,
    longitude: 36.8219,
    start: DateTime.now().add(const Duration(days: 20, hours: 6)),
    end: DateTime.now().add(const Duration(days: 20, hours: 12)),
    category: 'sports',
    coverImageUrl: 'https://images.unsplash.com/photo-1544776193-352d25ca82cd?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_sports_44',
    price: 2000,
    isFree: false,
    description: 'Run for conservation — 5k, 10k, and half marathon categories.',
    tags: const ['sports', 'running', 'charity'],
    rating: 4.2,
  ),
  Event(
    id: '5',
    title: 'Career Fair 2025',
    city: 'Nairobi',
    locationName: 'KICC',
    latitude: -1.2895,
    longitude: 36.8219,
    start: DateTime.now().add(const Duration(days: 12, hours: 9)),
    end: DateTime.now().add(const Duration(days: 12, hours: 17)),
    category: 'career',
    coverImageUrl: 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_career_09',
    price: 300,
    isFree: false,
    description: 'Meet top employers and attend CV and interview workshops.',
    tags: const ['career', 'jobs', 'networking'],
    rating: 4.1,
  ),
  Event(
    id: '6',
    title: 'Nairobi Jazz Night',
    city: 'Nairobi',
    locationName: 'The Alchemist',
    latitude: -1.2683,
    longitude: 36.7989,
    start: DateTime.now().add(const Duration(days: 3, hours: 19)),
    end: DateTime.now().add(const Duration(days: 3, hours: 23)),
    category: 'entertainment',
    coverImageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1600&auto=format&fit=crop',
    organizerId: 'org_ent_21',
    price: 1200,
    isFree: false,
    description: 'Live jazz performances from top Kenyan artists.',
    tags: const ['music', 'jazz', 'nightlife'],
    rating: 4.7,
  ),
];