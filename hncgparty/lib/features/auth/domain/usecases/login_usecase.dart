import 'package:hncg_app/core/utils/typedef.dart';
import 'package:hncg_app/features/auth/domain/entities/user.dart';
import 'package:hncg_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  ResultFuture<User> call(LoginParams params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}