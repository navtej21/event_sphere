import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:get/get.dart';

class OrganizerEventsController extends GetxController {

  final tabIndex = 0.obs;

  final isLiveLoading = true.obs;
  final isDraftLoading = true.obs;


  final liveEvents = <EventModel>[].obs;
  final draftEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLiveEvents();
    fetchDraftEvents();
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  Future<void> fetchLiveEvents() async {
    try {
      isLiveLoading.value = true;
      final result = await EventService.getLiveEvents();
      liveEvents.assignAll(result ?? []);
    } finally {
      isLiveLoading.value = false;
    }
  }

  Future<void> fetchDraftEvents() async {
    try {
      isDraftLoading.value = true;
      final result = await EventService.getDraftEvents();
      draftEvents.assignAll(result ?? []);
    } finally {
      isDraftLoading.value = false;
    }
  }

 
  Future<void> deleteEvent(int eventId) async {
    await EventService.deleteEvent(eventId);

    liveEvents.removeWhere((e) => e.eventId == eventId);
    draftEvents.removeWhere((e) => e.eventId == eventId);
  }

  
  Future<void> refreshAll() async {
    await Future.wait([
      fetchLiveEvents(),
      fetchDraftEvents(),
    ]);
  }
}
