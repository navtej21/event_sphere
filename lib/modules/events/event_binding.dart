import 'package:get/get.dart';

import '../../services/event_service.dart';
import 'event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventService>(() => EventService());
    Get.lazyPut<EventController>(() => EventController());
  }
}
