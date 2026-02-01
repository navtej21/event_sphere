import 'package:event_sphere/features/attendee/eventdashboard/event_discover_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_sphere/features/events/event_details/event_details_view.dart';

class EventDiscoverPage extends GetView<EventDiscoverController>{
    EventDiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

   
        if (controller.events.isEmpty) {
          return const Center(child: Text("No live events"));
        }


        return ListView.builder(
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            final event = controller.events[index];
            return ListTile(
              onTap: () {
                Get.to(() => EventDetailsView(event: event));
              },
              title: Text(event.title ?? ''),
              subtitle: Text(event.venue ?? ''),
              leading: const Icon(Icons.event),
            );
          },
        );
      }),
    );
  }
}
