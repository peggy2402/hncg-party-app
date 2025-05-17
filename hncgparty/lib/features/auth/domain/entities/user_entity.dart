import 'package:hncgparty/features/auth/data/models/user_model.dart';

class UserEntity {
  final int id;
  final String username;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final String? gender;
  final DateTime? birthday;
  final bool isVerified;
  final String? role;
  final String? status;
  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.bio,
    required this.gender,
    required this.birthday,
    required this.isVerified,
    required this.role,
    required this.status,
  });

  // Có thể thêm phương thức fromModel nếu cần
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      username: model.username,
      email: model.email,
      avatarUrl: model.avatarUrl,
      bio: model.bio,
      gender: model.gender,
      birthday: model.birthday,
      isVerified: model.isVerified,
      role: model.role,
      status: model.status,
    );
  }
}