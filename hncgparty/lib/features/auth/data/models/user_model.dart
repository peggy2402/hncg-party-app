import 'package:hncg_app/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String? username;
  final String? avatarUrl;
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    this.username,
    this.avatarUrl,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']?['id'] ?? '', // Xử lý null safety
      email: json['user']?['email'] ?? '',
      username: json['user']?['username'],
      avatarUrl: json['user']?['avatar_url'],
      token: json['token'],
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      username: username,
      avatarUrl: avatarUrl,
      token: token,
    );
  }
}