import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/modules/auth/welcome_view.dart';
import 'package:event_sphere/modules/events/create_event/create_event_view.dart';
import 'package:event_sphere/modules/events/update_event/update_event_view.dart';
import 'package:event_sphere/services/auth_service.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';

class OrganizerEventsScreen extends StatefulWidget {
  const OrganizerEventsScreen({super.key});

  @override
  State<OrganizerEventsScreen> createState() => _OrganizerEventsScreenState();
}

class _OrganizerEventsScreenState extends State<OrganizerEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late Future<List<EventModel>>? liveEventsFuture;
  late Future<List<EventModel>>? draftEventsFuture;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(children: [
        ListTile(
          title: Text("Logout"),
          leading: Icon(Icons.logout),
          onTap: () async {
            await AuthService.logout();
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            }
          },
        )
      ]),
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "My Events",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Live"),
            Tab(text: "Past"),
            Tab(text: "Draft"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateEventScreen(organizerId: 302),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder<List<EventModel>?>(
            future: EventService.getLiveEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Failed to load live events"));
              }

              final events = snapshot.data ?? [];

              if (events.isEmpty) {
                return const Center(child: Text("No live events"));
              }

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return ListTile(
                    title: Text(event.title ?? ''),
                    subtitle: Text(event.venue ?? ''),
                  );
                },
              );
            },
          ),
          const Center(
            child: Text("Past events coming soon"),
          ),
          FutureBuilder<List<EventModel>?>(
            future: EventService.getDraftEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Failed to load draft events"));
              }

              final events = snapshot.data ?? [];
              if (events.isEmpty) {
                return const Center(child: Text("No draft events"));
              }

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return ListTile(
                    onTap: () {
                      print("my number ${event.eventId}");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateEventScreen(event: event)));
                    },
                    title: Text(event.eventId.toString() ?? ''),
                    subtitle: const Text("draft"),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
