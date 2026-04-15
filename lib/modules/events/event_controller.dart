import 'package:get/get.dart';

import '../../models/event_model.dart';
import '../../services/event_service.dart';

class EventController extends GetxController {
  final EventService _service = Get.find();

  final events = <Event>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    final loadedEvents = await _service.fetchEvents();
    events.assignAll(loadedEvents);
    isLoading.value = false;
  }

  Event? findById(String id) {
    try {
      return events.firstWhere((event) => event.id == id);
    } catch (_) {
      return null;
    }
  }
}
