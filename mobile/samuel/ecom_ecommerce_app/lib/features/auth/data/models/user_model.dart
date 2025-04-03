import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? token,
  }) : super(
          id: id,
          name: name,
          email: email,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle both login and user profile responses
    final String id = json['_id'] ?? json['id'] ?? '';
    final String? token = json['access_token'];
    final Map<String, dynamic> userData = json['data'] ?? json;

    return UserModel(
      id: id,
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'access_token': token,
    };
  }
} 