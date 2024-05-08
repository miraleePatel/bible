///
/// Exception model class
///
// ignore_for_file: prefer_typing_uninitialized_variables

class ApiException implements Exception {
  final message;
  final prefix;
  ApiException([this.message, this.prefix]);
  @override
  String toString() {
    return "$prefix$message";
  }
}

///
/// throw exception when failed to communication with server
///
/// //
class FetchDataException extends ApiException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

///
/// throw exception when called invalid request
///
class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

///
/// throw exception when pass unauthorised user token
///
class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

///
/// throw exception when invalid input from userdata
///
class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
