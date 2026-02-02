import 'dart:convert';

import 'package:event_sphere/features/events/create_event/create_event_view.dart';
import 'package:event_sphere/features/events/update_event/update_event_view.dart';
import 'package:event_sphere/features/auth/welcome_view.dart';
import 'package:event_sphere/features/organizer/organizer_section/organizer_event_controller.dart';
import 'package:event_sphere/services/auth_service.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerEventsScreen extends StatelessWidget {
  OrganizerEventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              await AuthService.logout();
              Get.offAll(() => WelcomeScreen());
            },
          ),
        ),
        backgroundColor: const Color(0xFFF8F7F2),
        appBar: AppBar(
          title: const Text("My Events"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Live"),
              Tab(text: "Past"),
              Tab(text: "Draft"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateEventScreen(organizerId: 302)));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: TabBarView(
          children: [
            _liveTab(),
            const Center(child: Text("Past events coming soon")),
            _draftTab(context),
          ],
        ),
      ),
    );
  }

  Widget _liveTab() {
    final controller = Get.put(OrganizerEventsController());
    return Obx(() {
      if (controller.isLiveLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.liveEvents.isEmpty) {
        return const Center(child: Text("No live events"));
      }

      return ListView.builder(
        itemCount: controller.liveEvents.length,
        itemBuilder: (_, index) {
          final event = controller.liveEvents[index];
          return ListTile(
            title: Text(event.title ?? ''),
            subtitle: Text(event.venue ?? ''),
          );
        },
      );
    });
  }

  Widget _draftTab(BuildContext context) {
    final controller = Get.put(OrganizerEventsController());
    return Obx(() {
      if (controller.isDraftLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.draftEvents.isEmpty) {
        return const Center(child: Text("No draft events"));
      }

      return ListView.builder(
      
        itemCount: controller.draftEvents.length,
        itemBuilder: (_, index) {
          final event = controller.draftEvents[index];
          return ListTile(
            leading: Icon(Icons.update),
            title: Text(event.title ?? ''),
            subtitle: const Text("Draft"),
            onTap: ()  {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateEventScreen(event: event)));

              controller.refreshAll();
            },
          );
        },
      );
    });
  }
}
