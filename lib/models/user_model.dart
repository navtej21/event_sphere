class UserModel {
  final int userId;
  final String email;
  final String name;
  final String roles;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      roles: json['roles'],
    );
  }
}
