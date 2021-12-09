import 'ApiException.dart';

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(404, message);
}
