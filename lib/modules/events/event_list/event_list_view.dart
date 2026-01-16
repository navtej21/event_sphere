import 'package:flutter/material.dart';
import '../../../models/event_model.dart';
import '../../../services/event_service.dart';

class EventList extends StatelessWidget {
  final List<EventModel> events;
  final bool isDraft;
  final VoidCallback onRefresh;

  const EventList({
    super.key,
    required this.events,
    required this.isDraft,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(
        child: Text(
          "No events",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: events.length,
      itemBuilder: (_, i) {
        final e = events[i];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

         
            title: Text(
              e.title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

     
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                "${e.startDate} • ${e.venue}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ),

            
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isDraft)
                  IconButton(
                    icon: const Icon(
                      Icons.publish,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await EventService.publishEvent(e.eventId!, 302);
                      onRefresh();
                    },
                  ),

            e.status=='DRAFT'?      IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: const Color(0xFFF8F7F2),
                        title: const Text(
                          "Delete event?",
                          style: TextStyle(color: Colors.black),
                        ),
                        content: const Text(
                          "This action cannot be undone.",
                          style: TextStyle(color: Colors.black54),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await EventService.deleteEvent(e.eventId!);
                      onRefresh();
                    }
                  },
                ):IconButton(onPressed: (){}, icon: Icon(Icons.cancel)),
              ],
            ),
          ),
        );
      },
    );
  }
}
