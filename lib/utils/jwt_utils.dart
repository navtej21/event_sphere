// lib/utils/jwt_utils.dart
import 'dart:convert';
import '../models/user_role.dart';

UserRole extractRoleFromJwt(String token) {
  final parts = token.split('.');
  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  final Map<String, dynamic> decoded = jsonDecode(payload);

  return userRoleFromString(decoded['role']);
}
