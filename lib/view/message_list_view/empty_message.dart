import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

// メッセージ一覧のデータが0件の時に表示するWidget
class EmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserModeの取得
    var userMode = Provider.of<UserMode>(context);

    // Widgetの生成
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Center(
        child: userMode.isGodFlag
            ? Text(
                '迷える仔羊の悩みを解決しましょう',
                style: kTitleTextStyle.copyWith(color: Color(0xFF909090), fontSize: 18),
              )
            : Text(
                '迷いを神さまに質問しましょう',
                style: kTitleTextStyle.copyWith(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
