import 'dart:convert';

import 'package:event_sphere/core/api_constants.dart';
import 'package:event_sphere/models/attendee_form_model.dart';
import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/models/ticket_model.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



class TicketBookingService {


  static Future<void> bookTicket(int eventid,List<AttendeeFormModel> attendee) async {
    final token = await SecureStorage.getToken();

    final uri = Uri.parse('${ApiConstants.baseUrl}/booking');

    final attendeeList = attendee
        .map((attendee) => {
              'name': attendee.name,
              'email': attendee.email,
            })
        .toList();

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'eventId': eventid,
        'attendees': attendeeList,
      }),
    );

    debugPrint("BOOK TICKET STATUS: ${response.statusCode}");
    debugPrint("BOOK TICKET BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to book tickets');
    }
  }
}