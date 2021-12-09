import 'ApiException.dart';

class FetchDataException extends ApiException {
  FetchDataException(int statusCode, String message)
      : super(statusCode, message);
}
