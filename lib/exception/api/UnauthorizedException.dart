import 'ApiException.dart';

class UnauthorisedException extends ApiException {
  UnauthorisedException(int statusCode, String message)
      : super(statusCode, message);
}
