// lib/models/user_role.dart
enum UserRole {
  ATTENDEE,
  ORGANIZER,
  ADMIN,
}


UserRole userRoleFromString(String role) {
  return UserRole.values.firstWhere(
    (e) => e.name == role,
    orElse: () => UserRole.ATTENDEE,
  );
}