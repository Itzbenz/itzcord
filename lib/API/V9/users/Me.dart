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
    return get(additionalHeader: {
      "Authorization": token,
    });
  }

  @override
  Future<Account> fetch() async {
    Map<String, dynamic> data = await fetchJson();
    data["token"] = token;
    return Account.fromJson(data);
  }


}
