import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';

// メッセージ一覧画面のAppBarに表示するTextWidget
class MessagePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserModeの取得
    var userMode = Provider.of<UserMode>(context);

    // Widgetの生成
    return Text(
      'メッセージ一覧',
      style: TextStyle(
        color: userMode.isGodFlag ? Color(0xFF909090) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
