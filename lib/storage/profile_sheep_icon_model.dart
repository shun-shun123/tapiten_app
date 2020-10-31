import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapiten_app/storage/shared_preferences_keys.dart';

class ProfileSheepIconModel extends ChangeNotifier {
  static String resourceId;

  // 神さまモードの時のアイコンリソースIDを保存します
  Future saveProfileGodIconResource({@required String id}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesKeys.SheepIconResourceId, id);
    ProfileSheepIconModel.resourceId = id;
    notifyListeners();
  }

  // main()で一度呼び出されます。
  // アプリ起動時に「子羊」モードのプロフィールアイコンIDをロードします
  // 保存されていない場合はデフォルト画像をセットします
  Future<String> loadProfileGodIconModel() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    ProfileSheepIconModel.resourceId =
        sharedPreferences.getString(SharedPreferencesKeys.SheepIconResourceId) ?? 'sheep_01.png';
    return ProfileSheepIconModel.resourceId;
  }
}
