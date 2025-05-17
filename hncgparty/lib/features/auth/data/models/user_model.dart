// features/auth/data/models/user_model.dart
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String username,
    required String email,
    String? avatarUrl,
    String? bio,
    String? gender,
    DateTime? birthday,
    bool isVerified = false,
    String role = 'user',
    String status = 'active',
  }) : super(
    id: id,
    username: username,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    gender: gender,
    birthday: birthday,
    isVerified: isVerified,
    role: role,
    status: status,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      gender: json['gender'],
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      isVerified: json['is_verified'] ?? false,
      role: json['role'] ?? 'user',
      status: json['status'] ?? 'active',
    );
  }

  // Thêm phương thức toEntity()
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: gender,
      birthday: birthday,
      isVerified: isVerified,
      role: role,
      status: status,
    );
  }
}