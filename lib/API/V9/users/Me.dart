import 'package:http/http.dart' as http;
import 'package:itzcord/API/API.dart';
import 'package:itzcord/Model/Account.dart';
class Me extends API<Account> {
  String token;

  Me(this.token);

  @override
  String path() {
    return "users/@me";
  }

  @override
  Future<http.Response> fetchHttp() {
    return get();
  }

  @override
  Future<Account> fetch() async {
    Map<String, dynamic> data = await fetchJson();
    data["token"] = token;
    return fromJson(data);
  }

  static Account fromJson(Map<String, dynamic> json) {
    return Account(
        json['name'], json['discriminator'], json['avatar_url'], json['token']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
