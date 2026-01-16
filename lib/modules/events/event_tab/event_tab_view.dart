import 'package:flutter/material.dart';
import '../../../models/event_model.dart';
import '../event_list/event_list_view.dart';

class EventTab extends StatelessWidget {
  final List<EventModel> events;
  final bool? isDraft;
  final bool? isPast;
  final bool? isLive;
  final VoidCallback onRefresh;

  const EventTab({
    super.key,
    required this.events,
    required this.isDraft,
    required this.isPast,
    required this.isLive,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty && isDraft==true) {
      return Center(
        child: Text(
          "no draft events",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    else if(events.isEmpty && isLive==true){
      return Center(
        child: Text("no live events",style: TextStyle(color: Colors.grey.shade600),)
      );
    }

    else if(events.isEmpty && isPast==true){
      return Center(
        child: Text("no past events",style: TextStyle(color: Colors.grey.shade600),)
      );
    }

    return EventList(
      events: events,
      isDraft: true,
      onRefresh: onRefresh,
    );
  }
}
