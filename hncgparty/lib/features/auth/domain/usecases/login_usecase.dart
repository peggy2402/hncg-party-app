import 'package:dartz/dartz.dart';
import 'package:hncgparty/core/errors/failure.dart';
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}