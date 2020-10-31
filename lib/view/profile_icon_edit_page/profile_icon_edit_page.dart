import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/profile_god_icon_model.dart';
import 'package:tapiten_app/storage/profile_sheep_icon_model.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileIconEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 実際のXDに合わせてUIを実装する
    var userMode = Provider.of<UserMode>(context);
    return ChangeNotifierProvider(
      create: (context) => null,
      child: Scaffold(
        backgroundColor: userMode.isGodFlag ? Colors.white : Color(0xFF909090),
        appBar: AppBar(
          title: Text(
            'プロフィール',
            style: kTitleTextStyle.copyWith(
              fontSize: 20,
              color: userMode.isGodFlag ? Color(0xFF909090) : Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: userMode.isGodFlag ? Color(0xFF909090) : Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: userMode.isGodFlag ? Colors.white : Color(0xFF909090),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 180),
            child: Column(
              children: [
                Text(
                  UserMode.isGod ? 'どの神さまにしますか？' : 'どの仔羊にしますか？',
                  style: kTitleTextStyle.copyWith(
                    color: UserMode.isGod ? Color(0xFF909090) : Colors.white,
                    fontSize: 18,
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  shrinkWrap: true,
                  children: [
                    ProfileIconButton(
                      resourceId: UserMode.isGod ? 'god_01.png' : 'sheep_01.png',
                    ),
                    ProfileIconButton(
                      resourceId: UserMode.isGod ? 'god_02.png' : 'sheep_02.png',
                    ),
                    ProfileIconButton(
                      resourceId: UserMode.isGod ? 'god_03.png' : 'sheep_03.png',
                    ),
                    ProfileIconButton(
                      resourceId: UserMode.isGod ? 'god_04.png' : 'sheep_04.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  // assetsファイル下のファイル名
  final String resourceId;

  // 同時押し制御
  static bool isBusy = false;

  // コンストラクタ
  ProfileIconButton({
    @required this.resourceId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 80,
      onPressed: () async {
        if (ProfileIconButton.isBusy) {
          return;
        }
        ProfileIconButton.isBusy = true;
        if (UserMode.isGod) {
          var profileGodIconModel = Provider.of<ProfileGodIconModel>(context);
          await profileGodIconModel.saveProfileGodIconResource(id: resourceId);
        } else {
          var profileSheepIconModel = Provider.of<ProfileSheepIconModel>(context);
          await profileSheepIconModel.saveProfileGodIconResource(id: resourceId);
        }
        ProfileIconButton.isBusy = false;
        Navigator.of(context).pop();
      },
      icon: new Image.asset(
        "images/profile_icons/" + resourceId,
        width: 120,
        height: 120,
      ),
    );
  }
}
