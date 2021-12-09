import 'ApiException.dart';

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(400, message);
}
