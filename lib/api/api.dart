import 'dart:convert';

import 'package:http/http.dart' as http;

const baseurl = "https://interncovid.000webhostapp.com/";
const commonPath = baseurl + "covid";

class API {
  static Future<String> signin(String username, String password) async {
    Map<String, String> up = {"username": username, "password": password};
    http.Response res =
        await http.post(Uri.parse(commonPath + '/signin'), body: up);
    Map body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body['message'];
    } else if (res.statusCode == 409) {
      return 'Something Went wrong';
    } else {
      return body['error'];
    }
  }

  static Future<bool> logout(String username) async {
    http.Response res = await http
        .post(Uri.parse(commonPath + '/logout'), body: {"username": username});
    if (res.statusCode == 200) {
      return true;
    } else
      return false;
  }

  static Future<String> signup(username, password) async {
    Map<String, String> up = {"username": username, "password": password};
    http.Response res =
        await http.post(Uri.parse(commonPath + '/signup'), body: up);
    Map body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body['message'];
    } else {
      return body['error'];
    }
  }
}
