import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> getRememberMeValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("LoginValue") ?? false;
  }

  static Future<bool> setRememberMeValue(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("LoginValue", value);
  }

  static Future<bool> setMottoValue(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("MottoValue", value);
  }

  static Future<String> getMottoValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("MottoValue") ??
        "Sevdiklerin için sigarayı bırakmalısın!";
  }
}
