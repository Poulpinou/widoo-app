import 'AppException.dart';

class UnreachableServerException extends AppException {
  UnreachableServerException() : super("Server connection failed");
}
