abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  String toString() {
    return message;
  }
}
