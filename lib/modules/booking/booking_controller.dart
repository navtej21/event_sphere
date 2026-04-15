import 'package:get/get.dart';

import '../../models/booking_model.dart';
import '../../models/event_model.dart';
import '../../services/booking_service.dart';

class BookingController extends GetxController {
  final BookingService _service = Get.find();

  final bookings = <Booking>[].obs;
  final isRegistering = false.obs;

  @override
  void onInit() {
    super.onInit();
    bookings.assignAll(_service.getBookings());
  }

  bool isRegistered(String eventId) {
    return bookings.any((item) => item.eventId == eventId);
  }

  Future<void> register(Event event) async {
    if (isRegistered(event.id)) return;

    isRegistering.value = true;
    await Future.delayed(const Duration(milliseconds: 600));

    final booking = Booking(
      eventId: event.id,
      eventTitle: event.title,
      venue: event.venue,
      date: event.date,
      bookedAt: DateTime.now(),
    );

    _service.addBooking(booking);
    bookings.assignAll(_service.getBookings());
    isRegistering.value = false;
    Get.snackbar('Registration complete', 'You are registered for ${event.title}.');
  }
}
