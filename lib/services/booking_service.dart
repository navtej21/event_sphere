import 'dart:convert';

import 'package:event_sphere/core/api_constants.dart';
import 'package:event_sphere/models/attendee_form_model.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:http/http.dart' as http;
class BookingService{

  static Future<void> bookTicket(List<AttendeeFormModel> attendees,int eventId) async{

    final token=await SecureStorage.getToken();

    final uri=Uri.parse('${ApiConstants.baseUrl}/booking');
    final response= await http.post(
      uri,
      headers: {'Content-Type':'application/json','Authorization':'Bearer $token'},
      body: jsonEncode({
        'eventId':eventId,
        'attendees':attendees
      })
    );

    print('response status ${response.statusCode}');
    print('response body ${response.body}');
  
  }
}