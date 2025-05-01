import 'package:dartz/dartz.dart';
import 'package:hncgparty/core/errors/failure.dart';
import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/domain/entities/user_entity.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';
import 'package:hncgparty/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl({required this.dioClient});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final response = await dioClient.login(email: email, password: password);

      // Kiểm tra response có đúng cấu trúc
      if (response['user'] == null || response['token'] == null) {
        throw Failure('Invalid response structure');
      }

      final userModel = UserModel.fromJson(response['user'] as Map<String, dynamic>);
      final token = response['token'] as String;

      // Lưu token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return Right(userModel.toEntity()); // Sử dụng toEntity()
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

}