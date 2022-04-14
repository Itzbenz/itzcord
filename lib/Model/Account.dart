import 'package:itzcord/API/V9/users/Me.dart';

class Account {
  String token;
  String name;
  String discriminator;
  String avatar_url;
  String id;
  String? email, phone, bio, pronouns, locale;
  static final Uri me = Uri.parse("https://discord.com/api/users/@me");

  Account(
    this.token,
    this.name,
    this.discriminator,
    this.avatar_url,
    this.id, {
    this.email,
    this.phone,
    this.bio,
    this.pronouns,
    this.locale,
  }) {
    if (!avatar_url.startsWith("http")) {
      avatar_url = "https://cdn.discordapp.com/avatars/$id/$avatar_url.png";
    }
  }

  static Account fromJson(Map<String, dynamic> json) {
    return Account(
      json["token"],
      json["username"],
      json["discriminator"],
      json["avatar"],
      json["id"],
      email: json["email"],
      phone: json["phone"],
      bio: json["bio"],
      pronouns: json["pronouns"],
      locale: json["locale"],
    );
  }

  static Future<Account> fromToken(String token) {
    return Me(token).fetch();
  }

  static fromLogin(String username, String password) async {
    //sleep
    await Future.delayed(Duration(seconds: 3));
  }
}
