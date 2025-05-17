import 'package:dio/dio.dart';
import 'package:hncgparty/core/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/env.dart';
class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = AppEnv.baseUrl; // Android emulator -> localhost
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    _addAuthInterceptor();
  }
  // Thêm phương thức post public
  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['message'] ?? 'Lỗi mạng cần phải config mạng cục bộ',
        code: e.response?.statusCode,
      );
    }
  }

  // Thêm interceptor để tự động gắn JWT token
  void _addAuthInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Xử lý refresh token hoặc đăng xuất
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('jwt_token');
        }
        return handler.next(e);
      },
    ));
  }

  // Helper method xử lý response thống nhất
  Future<T> _handleResponse<T>(Future<Response> apiCall) async {
    try {
      final response = await apiCall;
      final data = response.data['data'];

      if (data is! T) {
        throw Failure('Invalid response type: expected $T, got ${data.runtimeType}');
      }

      return data as T;
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['message'] ?? 'Lỗi mạng cần phải config mạng cục bộ',
        code: e.response?.statusCode,
      );
    }
  }

  // ------------ API Methods ------------
  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    return _handleResponse<Map<String, dynamic>>(
      _dio.post('/api/v1/auth/login', data: {'identifier': identifier, 'password': password}),
    );
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return _handleResponse<Map<String, dynamic>>(
      _dio.post('/api/v1/auth/register', data: {
        'username': username,
        'email': email,
        'password': password,
      }),
    );
  }

  Future<Map<String, dynamic>> getProfile() async {
    return _handleResponse<Map<String, dynamic>>(
      _dio.get('/api/v1/auth/profile'),
    );
  }
}