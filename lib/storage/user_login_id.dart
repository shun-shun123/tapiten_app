import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapiten_app/storage/shared_preferences_keys.dart';

class UserLoginId {
  static String loginId;

  Future saveLoginId({@required String loginid}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesKeys.loginId, loginid);
    UserLoginId.loginId = loginid;
  }
}
