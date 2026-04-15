import '../models/event_model.dart';

class EventService {
  Future<List<Event>> fetchEvents() async {
    await Future.delayed(const Duration(milliseconds: 700));

    return [
      Event(
        id: 'event-1',
        title: 'Creative Tech Summit',
        venue: 'Downtown Conference Hall',
        date: DateTime.now().add(const Duration(days: 3)),
        description: 'A day of workshops, panels, and networking sessions focused on the latest in event technology.',
      ),
      Event(
        id: 'event-2',
        title: 'Open Air Networking',
        venue: 'City Park Lawn',
        date: DateTime.now().add(const Duration(days: 10)),
        description: 'An informal evening of mixers, live music, and community conversations under the stars.',
      ),
      Event(
        id: 'event-3',
        title: 'Product Launch Meetup',
        venue: 'Skyline Rooftop',
        date: DateTime.now().add(const Duration(days: 16)),
        description: 'Join founders, builders, and early adopters for a launch showcase and demo sessions.',
      ),
    ];
  }
}
