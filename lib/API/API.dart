import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itzcord/Vars.dart';

abstract class API<T> {
  static const String base_url = "https://discord.com/api/v9/";

  //http stuff
  Object? serialize() {
    return jsonEncode(this);
  }

  String path();

  Map<String, String> headers() {
    return {"Content-Type": "application/json", "User-Agent": userAgent()};
  }

  Uri toUri() {
    String p = path();
    if (p.startsWith("/")) {
      p = p.substring(1);
    }
    return Uri.parse(base_url + p);
  }

  //get, post, patch, put, delete
  Future<http.Response> get() {
    return http.get(toUri(), headers: headers());
  }

  Future<http.Response> post() {
    return http.post(toUri(), headers: headers(), body: serialize());
  }

  Future<http.Response> patch() {
    return http.patch(toUri(), headers: headers(), body: serialize());
  }

  Future<http.Response> put() {
    return http.put(toUri(), headers: headers(), body: serialize());
  }

  Future<Map<String, dynamic>> fetchJson() async {
    http.Response response = await post();
    return jsonDecode(response.body);
  }

  Future<T> fetch();
}
