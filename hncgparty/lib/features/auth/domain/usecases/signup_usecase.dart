// features/auth/domain/usecases/signup_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:hncgparty/core/errors/failure.dart';
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(
      String username,
      String email,
      String password,
      ) async {
    return await repository.signup(username, email, password);
  }
}