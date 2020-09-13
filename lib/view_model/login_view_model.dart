import 'package:flutter/material.dart';
import 'package:game_tv_app/model/repository/base_repository.dart';
import 'package:game_tv_app/utils/share_preference_helper.dart';

class LoginViewModel with ChangeNotifier {

  Future<bool> tryLoggingIn(String phoneNumber, String password) async {
    bool isLoggedIn = BaseRepository().verifyUser(phoneNumber, password);
    await SharePreferenceHelper().setLoggedInStatus(isLoggedIn);
    return isLoggedIn;
  }

  Future<bool> isLoggedIn() async {
    return await SharePreferenceHelper().isLoggedIn();
  }
}
