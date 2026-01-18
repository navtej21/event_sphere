import 'dart:convert';

import 'package:event_sphere/core/api_constants.dart';
import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  static String baseUrl = "${ApiConstants.baseUrl}/api/favorites";

  static Future<List<EventModel>> getFavoriteEvents() async {

    final token=SecureStorage.getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to fetch favorite events: ${response.statusCode}",
      );
    }
  }


  static Future<bool> isFavorite({
    required int eventId,
    required String token,
  }) async {
    final res = await http.get(
      Uri.parse('${baseUrl}/status?eventId=$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return res.body == 'true';
    }

    throw Exception("Failed to load favorite");
  }


  static Future<bool> toggleFavorite({
    required int eventId,
    required String token,
  }) async {

    print("i am have beign pressed");
    final res = await http.post(
      Uri.parse('${baseUrl}/toggle?eventId=$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return res.body == 'true';
    }

    throw Exception("Failed to toggle favorite");
  }
}
