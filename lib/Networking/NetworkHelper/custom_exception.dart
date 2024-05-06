import 'package:flutter/cupertino.dart';

class CustomException implements Exception {
  final message;
  final prefix;
  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([BuildContext? context, String? message])
      : super(message, "Fetch data exception");
}

class BadRequestException extends CustomException {
  BadRequestException([BuildContext? context, message])
      : super(message, "Bad request exception");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([BuildContext? context, message])
      : super(message, "UnAuthenticate data exception");
}

class InvalidInputException extends CustomException {
  InvalidInputException([BuildContext? context, String? message])
      : super(message, "Invalid data exception");
}