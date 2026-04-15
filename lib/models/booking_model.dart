class Booking {
  final String eventId;
  final String eventTitle;
  final String venue;
  final DateTime date;
  final DateTime bookedAt;

  Booking({
    required this.eventId,
    required this.eventTitle,
    required this.venue,
    required this.date,
    required this.bookedAt,
  });
}
