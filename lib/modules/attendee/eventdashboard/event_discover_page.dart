import 'dart:async';

import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/modules/events/event_details/event_details_view.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:flutter/material.dart';

class EventDiscoverPage extends StatefulWidget {
  const EventDiscoverPage({super.key});

  @override
  State<EventDiscoverPage> createState() => _EventDiscoverPageState();
}

class _EventDiscoverPageState extends State<EventDiscoverPage> {

  final TextEditingController _searchcontroller=TextEditingController();
  Timer? _debounce;

  bool _isloading=true;
  List<EventModel> _events=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: const Color(0xFFF8F7F2),
      body: FutureBuilder<List<EventModel>?>(
        future: EventService.getLiveEvents(),
        builder: (context, snapshot) {
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            print(snapshot.data);
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("this is the error ${snapshot.error}");
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
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventDetailsView(event: event)));
                },
                title: Text(event.title ?? ''),
                subtitle: Text(event.venue ?? ''),
                leading: const Icon(Icons.event),
              );
            },
          );
        },
      ),
    );
  }
}
