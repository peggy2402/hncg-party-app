import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? username;
  final String? avatarUrl;
  final String? token;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.avatarUrl,
    this.token,
  });

  // Empty user
  static const empty = User(id: '', email: '');

  @override
  List<Object?> get props => [id, email, username, avatarUrl, token];
}