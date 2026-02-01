import 'dart:convert';
import 'package:event_sphere/core/api_constants.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  static Future<List<EventModel>> getEvents() async {
    final token = await SecureStorage.getToken();

    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/events/organizerevents'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      print(token);
      final List data = jsonDecode(response.body);

      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  static Future<List<EventModel>> getDraftEvents() async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/organizer/events/draft'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json'
        });

    print(token);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      print(data);

      print("draft events ${response.statusCode}");

      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("failed to load events");
    }
  }

  static Future<List<EventModel>?> getLiveEvents() async {
    final token = await SecureStorage.getToken();

    final response = await http
        .get(Uri.parse('http://${ApiConstants.baseUrl}/events/live'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      print("my data is this ${data}");

      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      throw Exception("no events can be found");
    }
  }

  static Future<void> createEvent(
    Map<String, dynamic> body,
  ) async {
    final token = await SecureStorage.getToken();
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/organizer/events'),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(body),
    );
    print("my token ${token}");
    print("event status code ${res.statusCode}");

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception(res.body);
    }
  }

  static Future<void> updateEvent(
      int eventId, Map<String, dynamic> body) async {
    final token = await SecureStorage.getToken();
    final res = await http.put(
      Uri.parse(
        '${ApiConstants.baseUrl}/events/update?eventId=$eventId',
      ),
      headers: {
        "Authorization": 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: jsonEncode(body),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to update event");
    }
  }

  static Future<void> deleteEvent(
    int eventId,
  ) async {
    final token = await SecureStorage.getToken();
    final res = await http.delete(
        Uri.parse(
          '${ApiConstants.baseUrl}/organizer/events/${eventId}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });

    if (res.statusCode != 200) {
      throw Exception("Failed to delete event");
    }
  }

  static Future<EventModel> getEventInfo(int eventid) async {
    final res = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/events/getinfo/$eventid'));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load the event info");
    }
  }

  static Future<void> publishEvent(
    int eventId,
    int organizerId,
  ) async {
    final token = await SecureStorage.getToken();
    final res = await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/events/publish?eventId=$eventId',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to publish event");
    }
  }
}
