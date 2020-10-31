import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapiten_app/storage/shared_preferences_keys.dart';

class ProfileGodIconModel extends ChangeNotifier {
  static String resourceId;

  // 神さまモードの時のアイコンリソースIDを保存します
  Future saveProfileGodIconResource({@required String id}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesKeys.GodIconResourceId, id);
    ProfileGodIconModel.resourceId = id;
    notifyListeners();
  }

  // main()で一度呼び出されます。
  // アプリ起動時に「神様」モードのプロフィールアイコンIDをロードします
  // 保存されていない場合はデフォルト画像をセットします
  Future<String> loadProfileGodIconModel() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    ProfileGodIconModel.resourceId =
        sharedPreferences.getString(SharedPreferencesKeys.GodIconResourceId) ?? 'god_01.png';
    return ProfileGodIconModel.resourceId;
  }
}
