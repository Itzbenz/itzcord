import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itzcord/DiscordException.dart';
class Account{
  final String token;
  final String name;
  final String discriminator;
  final String avatar_url;
  static final Uri me = Uri.parse("https://discord.com/api/users/@me");
  Account(this.name, this.discriminator, this.avatar_url, this.token);
  static Future<Account> retrieve(String token) async{
    var response = await http.get(me, headers: {
      "Authorization": token
    });
    var json = jsonDecode(response.body);
    if(response.statusCode == 200){
      return Account(json["username"], json["discriminator"], json["avatar"], token);
    }

    throw DiscordException(json["message"], json["code"], response.statusCode);
  }

  static Account fromJson(Map<String, dynamic> json){
    return Account(json['name'], json['discriminator'], json['avatar_url'], json['token']);
  }

}