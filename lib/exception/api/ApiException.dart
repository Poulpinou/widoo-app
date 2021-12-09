import '../AppException.dart';

abstract class ApiException extends AppException {
  final int statusCode;

  ApiException(this.statusCode, String message) : super(message);
}
