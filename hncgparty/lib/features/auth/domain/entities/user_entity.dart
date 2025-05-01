import 'package:hncgparty/features/auth/data/models/user_model.dart';

class UserEntity {
  final int id;
  final String username;
  final String email;
  final String? avatarUrl;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.avatarUrl,
  });

  // Có thể thêm phương thức fromModel nếu cần
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      username: model.username,
      email: model.email,
      avatarUrl: model.avatarUrl,
    );
  }
}