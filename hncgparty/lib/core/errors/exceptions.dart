import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException({required super.message, super.statusCode});

  factory ServerException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerException(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerException(message: 'Receive timeout');
      case DioExceptionType.badResponse:
        return ServerException.fromResponse(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');
      default:
        return ServerException(message: 'Something went wrong');
    }
  }

  factory ServerException.fromResponse(int? statusCode, dynamic response) {
    final message = response['message'] ?? 'Something went wrong';
    return ServerException(message: message, statusCode: statusCode);
  }
}