import 'package:event_sphere/features/organizer/organizer_section/organizer_event_controller.dart';
import 'package:get/get.dart';

class OrganizerEventBinding extends Bindings{


  @override
  void dependencies()
  {
    Get.lazyPut<OrganizerEventsController>(()=>OrganizerEventsController());
  }
}