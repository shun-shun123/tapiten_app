import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapiten_app/storage/shared_preferences_keys.dart';

class UserId {
  static String userId;

  Future saveUserId({@required String id}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesKeys.userId, id);
    UserId.userId = id;
  }

  // main()で一度呼び出されます
  // アプリ起動時にユーザIDがローカルに保存されているかを確認します
  // ユーザIDはstaticな変数に設定されるので起動以降はstatic変数を参照してください
  Future<String> loadUserId() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    UserId.userId = sharedPreferences.getString(SharedPreferencesKeys.userId) ?? '';
    return UserId.userId;
  }
}
