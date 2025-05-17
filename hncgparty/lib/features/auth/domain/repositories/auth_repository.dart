import 'package:hncgparty/core/errors/failure.dart';
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signup(
      String username,
      String email,
      String password,
      );
  Future<Either<Failure, UserEntity>> login(String email, String password);
}