class Failure {
  final String message;
  final int? code; // HTTP status code

  Failure(this.message, {this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
class ServerFailure extends Failure {
  ServerFailure(String message, {int? code}) : super(message, code: code);
}