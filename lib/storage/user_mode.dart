import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapiten_app/storage/shared_preferences_keys.dart';

class UserMode {
  // アプリ実行中常に神様モードか子羊モードかを判定するためのフラグとなる
  static bool isGod = true;

  // SharedPreferencesへのセーブと共に、アプリ実行中にモード管理を行うstatic変数も更新する
  Future saveUserMode({@required bool isGod}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreferencesKeys.userMode, isGod);
    UserMode.isGod = isGod;
  }

  // main()で一度呼び出される
  // アプリ起動時に一度呼び出して仕舞えばいいだけで、
  // モードが変更された場合はstaticな変数をそのまま書き換えれば良い
  Future<bool> loadUserMode() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(SharedPreferencesKeys.userMode) ?? true;
  }
}
