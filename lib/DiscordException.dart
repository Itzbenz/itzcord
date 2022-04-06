import 'dart:io';

class DiscordException extends IOException{
  final String message;
  final int code, httpCode;

  DiscordException(this.message, this.code, this.httpCode);

  @override
  String toString() {
    return 'DiscordException: $message';
  }
}