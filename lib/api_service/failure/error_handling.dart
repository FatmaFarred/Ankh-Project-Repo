class Failure {
  String? errorMessage;

  Failure({required this.errorMessage});
}

class ServerError extends Failure {
  ServerError({required super.errorMessage});
}

class NetworkError extends Failure {
  NetworkError({required super.errorMessage});
}
class AuthFailure implements Exception {
  final String message;

  AuthFailure(this.message);

  @override
  String toString() => message;
}