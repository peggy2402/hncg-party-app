import 'package:hncg_app/core/utils/typedef.dart';
import 'package:hncg_app/features/auth/domain/entities/user.dart';
import 'package:hncg_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  ResultFuture<User> call(RegisterParams params) async {
    return await _repository.register(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String username;

  RegisterParams({
    required this.email,
    required this.password,
    required this.username,
  });
}