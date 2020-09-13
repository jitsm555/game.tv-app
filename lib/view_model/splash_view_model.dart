import 'package:flutter/material.dart';
import 'package:game_tv_app/utils/share_preference_helper.dart';

class SplashViewModel with ChangeNotifier {
  Future<bool> isLoggedIn() async {
    await Future.delayed(Duration(seconds: 2));
    return await SharePreferenceHelper().isLoggedIn();
  }
}
