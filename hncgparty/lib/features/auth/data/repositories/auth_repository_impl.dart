import 'package:dio/dio.dart';
import 'package:hncg_app/core/errors/exceptions.dart';
import 'package:hncg_app/core/network/dio_client.dart';
import 'package:hncg_app/features/auth/data/models/user_model.dart';
import 'package:hncg_app/features/auth/domain/entities/user.dart';
import 'package:hncg_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl({required this.dioClient});

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await dioClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data).toEntity();
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await dioClient.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'username': username,
        },
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data).toEntity();
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dioClient.post('/auth/logout');
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}