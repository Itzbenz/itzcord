import 'dart:io';

class DiscordException extends IOException {
  final String message;
  late final int code;

  DiscordException(this.message, this.code);

  static DiscordException from(Map<String, dynamic> response) {
    int lolCode = 200;
    if (response.containsKey('code')) {
      lolCode = response['code'];
    }
    String lolMessage = "";
    if (response.containsKey('message')) {
      lolMessage = response['message'];
    }
    return DiscordException(lolMessage, lolCode);
  }

  @override
  String toString() {
    return '$message';
  }
}
