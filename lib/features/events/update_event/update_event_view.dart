import 'package:event_sphere/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'update_event_controller.dart';

class UpdateEventScreen extends StatelessWidget {
  final EventModel event;

  const UpdateEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEventController(event));

    return Scaffold(
      appBar: AppBar(
        

        title: const Text("Update Event"),
        actions: [

          IconButton(onPressed: (){}, icon: Icon(Icons.done)),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: controller.deleteEvent,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _field("Title", controller.titleController),
            _field("Description", controller.descriptionController),
            _field("Venue", controller.venueController),
            _field("Capacity", controller.capacityController,
                number: true),

            Obx(() => _tile(
                  "Start Date",
                  controller.startDate.value
                      .toString()
                      .split(" ")
                      .first,
                  () => controller.pickDate(true),
                )),
            Obx(() => _tile(
                  "Start Time",
                  controller.startTime.value.format(context),
                  () => controller.pickTime(true),
                )),
            Obx(() => _tile(
                  "End Date",
                  controller.endDate.value
                      .toString()
                      .split(" ")
                      .first,
                  () => controller.pickDate(false),
                )),
            Obx(() => _tile(
                  "End Time",
                  controller.endTime.value.format(context),
                  () => controller.pickTime(false),
                )),

            const SizedBox(height: 24),

            
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: number ? TextInputType.number : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _tile(String title, String value, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
