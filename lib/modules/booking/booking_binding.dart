import 'package:get/get.dart';

import '../../services/booking_service.dart';
import 'booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingService>(() => BookingService(), fenix: true);
    Get.lazyPut<BookingController>(() => BookingController());
  }
}
