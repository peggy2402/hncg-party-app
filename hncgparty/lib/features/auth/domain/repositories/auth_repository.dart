import 'package:hncg_app/core/utils/typedef.dart';
import 'package:hncg_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  ResultFuture<User> login({
    required String email,
    required String password,
  });

  ResultFuture<User> register({
    required String email,
    required String password,
    required String username,
  });

  ResultVoid logout();
}