import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/modules/events/event_details/event_details_view.dart';
import 'package:event_sphere/services/favorite_service.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';

class AttendeeFavoriteView extends StatefulWidget {
  const AttendeeFavoriteView({super.key});

  @override
  State<AttendeeFavoriteView> createState() => _AttendeeFavoriteViewState();
}

class _AttendeeFavoriteViewState extends State<AttendeeFavoriteView> {
  


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: FutureBuilder<List<EventModel>?>(
        future: FavoriteService.getFavoriteEvents(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return const Center(child: Text("Something went wrong"));
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text("No favorite events"));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];

              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          EventDetailsView(event: event),
                    ),
                  );
                },
                title: Text(event.title ?? ''),
                subtitle: Text(event.venue ?? ''),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              );
            },
          );
        },
      ),
    );
  }

  
  
}
