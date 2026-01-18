import 'dart:convert';
import 'package:event_sphere/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/api_constants.dart';
import '../models/user_role.dart';

class AuthService {
  static Future<bool> register(
      {required String name,
      required String email,
      required String password,
      required UserRole role}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/register');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role.name,
      }),
    );

    debugPrint("REGISTER STATUS: ${response.statusCode}");
    debugPrint("REGISTER BODY: ${response.body}");

    return response.statusCode == 200;
  }

  static Future<bool> checkIfExists(String email) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/exists')
        .replace(queryParameters: {
      'email': email,
    });

    

    final response = await http.get(uri);

    debugPrint("EXISTS STATUS: ${response.statusCode}");
    debugPrint("EXISTS BODY: ${response.body}");
  

    print("my status code ${response.statusCode}");

    if (response.statusCode == 200) {
      return response.body.toLowerCase() == 'true';
    }

    throw Exception('Failed to check user existence');
  }

  static Future<void> logout() async {
    await SecureStorage.deleteToken();
    print("i have clicked");

    }
    
  

 static   Future<String?> login(
      {required String email, required String password}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print("my function is beign called");
    debugPrint("LOGIN STATUS: ${response.statusCode}");
    debugPrint("LOGIN BODY: ${response.body}");

    if (response.statusCode == 200) {
      return response.body; // JWT token
    }

    return null;
  }

}

