import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }

  // Thêm phương thức chuyển đổi sang Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}