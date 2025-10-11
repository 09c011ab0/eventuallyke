import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.title,
    required this.city,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.start,
    required this.end,
    required this.category,
    required this.coverImageUrl,
    required this.organizerId,
    this.price,
    this.isFree = false,
    this.description,
    this.tags = const [],
    this.rating,
  });

  final String id;
  final String title;
  final String city; // Nairobi, Mombasa, Kisumu, etc.
  final String locationName; // Venue name
  final double latitude;
  final double longitude;
  final DateTime start;
  final DateTime end;
  final String category; // music, culture, sports, tech, conference, career, entertainment
  final String coverImageUrl;
  final String organizerId;
  final int? price; // in KES
  final bool isFree;
  final String? description;
  final List<String> tags;
  final double? rating; // average rating 0-5

  @override
  List<Object?> get props => [
        id,
        title,
        city,
        locationName,
        latitude,
        longitude,
        start,
        end,
        category,
        coverImageUrl,
        organizerId,
        price,
        isFree,
        description,
        tags,
        rating,
      ];

  Event copyWith({
    String? id,
    String? title,
    String? city,
    String? locationName,
    double? latitude,
    double? longitude,
    DateTime? start,
    DateTime? end,
    String? category,
    String? coverImageUrl,
    String? organizerId,
    int? price,
    bool? isFree,
    String? description,
    List<String>? tags,
    double? rating,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      city: city ?? this.city,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      start: start ?? this.start,
      end: end ?? this.end,
      category: category ?? this.category,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      organizerId: organizerId ?? this.organizerId,
      price: price ?? this.price,
      isFree: isFree ?? this.isFree,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
    );
  }
}
