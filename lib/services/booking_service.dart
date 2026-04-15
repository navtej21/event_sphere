import '../models/booking_model.dart';

class BookingService {
  final List<Booking> _bookings = [];

  List<Booking> getBookings() => List.unmodifiable(_bookings);

  void addBooking(Booking booking) {
    _bookings.add(booking);
  }
}
