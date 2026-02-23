import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateEventController extends GetxController {
  final EventModel event;

  UpdateEventController(this.event);


  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController venueController;
  late final TextEditingController capacityController;


  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final startTime = TimeOfDay.now().obs;
  final endTime = TimeOfDay.now().obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    titleController = TextEditingController(text: event.title ?? '');
    descriptionController =
        TextEditingController(text: event.description ?? '');
    venueController = TextEditingController(text: event.venue ?? '');
    capacityController =
        TextEditingController(text: event.capacity?.toString() ?? '');

    startDate.value =
        DateTime.tryParse(event.startDate ?? '') ?? DateTime.now();
    endDate.value =
        DateTime.tryParse(event.endDate ?? '') ?? DateTime.now();
    startTime.value = _parseTime(event.startTime) ?? TimeOfDay.now();
    endTime.value = _parseTime(event.endTime) ?? TimeOfDay.now();
  }

  TimeOfDay? _parseTime(String? time) {
    if (time == null) return null;
    final parts = time.split(":");
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: isStart ? startDate.value : endDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      isStart ? startDate.value = picked : endDate.value = picked;
    }
  }

  Future<void> pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: isStart ? startTime.value : endTime.value,
    );
    if (picked != null) {
      isStart ? startTime.value = picked : endTime.value = picked;
    }
  }

  Future<void> updateEvent() async {
    if (startDate.value.isAfter(endDate.value)) {
      Get.snackbar("Error", "Start date cannot be after end date");
      return;
    }

    isLoading.value = true;

    final body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "venue": venueController.text,
      "capacity": int.tryParse(capacityController.text) ?? 0,
      "startDate": _date(startDate.value),
      "endDate": _date(endDate.value),
      "startTime": _time(startTime.value),
      "endTime": _time(endTime.value),
    };

    try {
      await EventService.updateEvent(event.eventId!, body);
      Get.back(result: true);
      Get.snackbar("Success", "Event updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEvent() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete Event"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Delete",
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await EventService.deleteEvent(event.eventId!);
      Get.back(result: true);
      Get.snackbar("Deleted", "Event deleted");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  String _date(DateTime d) => d.toIso8601String().split("T").first;
  String _time(TimeOfDay t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    venueController.dispose();
    capacityController.dispose();
    super.onClose();
  }
}
