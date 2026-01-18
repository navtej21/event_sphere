import 'package:event_sphere/models/attendee_form_model.dart';

class BookingRequestDTO{
  final int eventId;
  final List<AttendeeFormModel> attendees;

  BookingRequestDTO({
    required this.eventId,
    required this.attendees
  });


  Map<String,dynamic> toJson()
  {
    return {
      'eventId':eventId,
      'attendees':attendees.map((attendee)=>attendee.toJson()).toList()
    };
  }
}