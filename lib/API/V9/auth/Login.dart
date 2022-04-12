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
  Future fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }
}
