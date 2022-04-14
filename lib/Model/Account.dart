import 'package:itzcord/API/V9/users/Me.dart';

class Account {
  String token;
  String username;
  String discriminator;
  String avatar_url;
  String id;
  String? email, phone, bio, pronouns, locale;
  int? premium_type, flags;
  bool? verified, mfa_enabled, bot;
  static final Uri me = Uri.parse("https://discord.com/api/users/@me");

  Account(
    this.token,
    this.username,
    this.discriminator,
    this.avatar_url,
    this.id, {
    this.email,
    this.phone,
    this.bio,
    this.pronouns,
    this.locale,
    this.premium_type,
    this.flags,
    this.verified,
    this.mfa_enabled,
    this.bot,
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
      premium_type: json["premium_type"],
      flags: json["flags"],
      verified: json["verified"],
      mfa_enabled: json["mfa_enabled"],
      bot: json["bot"],
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
