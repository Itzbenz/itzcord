import 'package:itzcord/API/API.dart';

class Login extends API {
  String login;
  String password;
  String? captcha_key;
  String? login_source;
  bool undelete = false;

  Login(this.login, this.password, {this.captcha_key, this.login_source});

  @override
  String path() {
    return "api/v9/auth/login";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "password": password,
      "captcha_key": captcha_key,
      "login_source": login_source,
      "undelete": undelete,
    };
  }

  @override
  Future fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
