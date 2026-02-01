import 'dart:async';
import 'package:get/get.dart';
import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';

class EventDiscoverController extends GetxController {
 

  final isLoading = true.obs;
  final events = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLiveEvents();
  }

  Future<void> fetchLiveEvents() async {
    try {
      isLoading.value = true;
      final result = await EventService.getLiveEvents();
      events.assignAll(result ?? []);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  
}
