import 'package:shared_preferences/shared_preferences.dart';

String user = "username";

class SharedPref {
  static Future<bool> addUserToSP(username) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return await instance.setString(user, username);
  }

  static Future<SharedPreferences> getUsername() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance;
  }
}
