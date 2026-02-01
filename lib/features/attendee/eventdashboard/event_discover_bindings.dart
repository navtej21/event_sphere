import 'package:event_sphere/features/attendee/eventdashboard/event_discover_controller.dart';
import 'package:get/get.dart';

class EventDiscoverBidnings extends Bindings{

  
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<EventDiscoverController>(()=> EventDiscoverController());
  }
}