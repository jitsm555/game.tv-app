import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper {
  factory SharePreferenceHelper() {
    return _instance;
  }

  SharePreferenceHelper._internal();

  static final SharePreferenceHelper _instance =
      SharePreferenceHelper._internal();

  Future<void> setLoggedInStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }
}
