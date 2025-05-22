class Failure {
  final String message;
  final int? code; // HTTP status code

  Failure(this.message, {this.code});

  @override
  String toString() => 'Error: $message, code: $code';
}
class ServerFailure extends Failure {
  ServerFailure(super.message, {super.code});
}