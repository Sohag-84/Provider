// ignore_for_file: prefer_typing_uninitialized_variables, annotate_overrides

class AppException implements Exception {
  final message;
  final prefix;
  AppException([this.message, this.prefix]);

  String toString() {
    return "$message$prefix";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error during communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid input');
}
