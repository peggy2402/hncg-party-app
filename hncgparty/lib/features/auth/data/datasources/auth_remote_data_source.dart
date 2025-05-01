import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    // Kiểm tra và parse response
    final responseData = response.data;
    if (responseData['data'] == null) {
      throw Exception('Invalid response format: missing data field');
    }

    return UserModel.fromJson(responseData['data']['user']); // Giả sử backend trả về {'data': {'user': {...}}}
  }
}