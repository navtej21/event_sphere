import 'package:event_sphere/modules/organizer/my_events/organizer_screen.dart';
import 'package:flutter/material.dart';

class OrganizerHomeScreen extends StatefulWidget {
  const OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {
  void _init() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrganizerEventsScreen(),
    );
  }
}
