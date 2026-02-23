import 'dart:convert';
import 'package:event_sphere/core/api_constants.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {

  static Future<Map<String, String>> _headers() async {
    final token = await SecureStorage.getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }




  static Future<List<EventModel>> getEvents() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    }
    throw Exception("Failed to load organizer events");
  }


  static Future<List<EventModel>> getDraftEvents() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events/draft'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    }
    throw Exception("Failed to load draft events");
  }


  static Future<void> createEvent(Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events'),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception(res.body);
    }
  }

  static Future<void> updateEvent(int eventId, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events/$eventId'),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to update event");
    }
  }

  
  static Future<void> deleteEvent(int eventId) async {
    final res = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events/$eventId'),
      headers: await _headers(),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to delete event");
    }
  }

  
  static Future<void> publishEvent(int eventId) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events/$eventId/publish'),
      headers: await _headers(),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to publish event");
    }
  }

  /// PUT /organizer/events/{id}/cancel
  static Future<void> cancelEvent(int eventId) async {
    final res = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events/$eventId/cancel'),
      headers: await _headers(),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to cancel event");
    }
  }

  // ================= PUBLIC =================

  /// GET /events/live
  static Future<List<EventModel>> getLiveEvents() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/events/live'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    }
    throw Exception("No live events found");
  }

  /// GET /events/getinfo/{id}
  static Future<EventModel> getEventInfo(int eventId) async {
    final res = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/events/getinfo/$eventId'),
    );

    if (res.statusCode == 200) {
      return EventModel.fromJson(jsonDecode(res.body));
    }
    throw Exception("Failed to load event info");
  }
}