class CustomException implements Exception {
  final _message;
  final _code;
  final _prefix;

  CustomException([this._code, this._message, this._prefix]);

  String get message => _message;
  String get code => _code;
  String get prefix => _prefix;

  @override
  String toString() {
    return '$_prefix: $_message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([int? code, String? message]) : super(code, message, "FetchDataException");
}

class BadRequestException extends CustomException {
  BadRequestException([int? code, String? message]) : super(code, message, "Invalid Request");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([int? code,String? message]) : super(code, message, "Unauthorised");
}

class InvalidInputException extends CustomException {
  InvalidInputException([int? code,String? message]) : super(code, message, "Invalid Input");
}

class UnknownException extends CustomException {
  UnknownException([int? code,String? message]) : super(code, message, "Unknown Response");
}
