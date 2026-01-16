import 'package:event_sphere/models/event_model.dart';
import 'package:flutter/material.dart';

class FavoriteEvents extends StatefulWidget {
  final List<EventModel> favoriteEvents;
  const FavoriteEvents({super.key, required this.favoriteEvents});

  @override
  State<FavoriteEvents> createState() => _FavoriteEventsState();
}

class _FavoriteEventsState extends State<FavoriteEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Events",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final event = widget.favoriteEvents[index];

          return ListTile(
            title: Text(event.title!),
            subtitle: Text(event.startDate!),
          );
        },
        itemCount: widget.favoriteEvents.length,
      ),
    );
  }
}
