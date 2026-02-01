import 'package:event_sphere/features/attendee/bottombar/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class AttendeeBottomNavbarBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<AttendeeBottomNav>(() => AttendeeBottomNav());
  }
}
