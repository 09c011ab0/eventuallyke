class Review {
  Review({
    required this.eventId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String eventId;
  final String userName;
  final int rating; // 1-5
  final String comment;
  final DateTime createdAt;
}
