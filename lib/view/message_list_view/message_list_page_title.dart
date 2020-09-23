import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class MessagePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    return Text(
      'メッセージ一覧',
      style: TextStyle(
        color: userMode.isGodFlag ? Color(0xFF909090) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
