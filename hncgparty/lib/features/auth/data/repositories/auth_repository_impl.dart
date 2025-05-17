import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hncgparty/core/errors/failure.dart';
import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/data/models/user_model.dart';
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl({required this.dioClient});

  @override
  Future<Either<Failure, UserEntity>> signup(
      String username,
      String email,
      String password,
      ) async {
    try {
      final response = await dioClient.register(
        username: username,
        email: email,
        password: password,
      );

      final userModel = UserModel.fromJson(response['user']);
      final token = response['token'] as String;

      // Lưu token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(String identifier, String password) async {
    try {
      final response = await dioClient.login(
        identifier: identifier,
        password: password,
      );

      final userModel = UserModel.fromJson(response['user']);
      final token = response['token'] as String;

      // Lưu token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}