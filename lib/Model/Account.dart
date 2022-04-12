import 'package:itzcord/API/V9/users/Me.dart';

class Account {
  String token;
  String name;
  String discriminator;
  String avatar_url;
  static final Uri me = Uri.parse("https://discord.com/api/users/@me");

  Account(this.name, this.discriminator, this.avatar_url, this.token);

  static Future<Account> fromToken(String token) {
    return Me(token).fetch();
  }
}
