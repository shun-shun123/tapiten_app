import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class MessageDetailPageQuestionText extends StatelessWidget {
  final String content;
  MessageDetailPageQuestionText({this.content});

  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    var fontColor = userMode.isGodFlag ? Colors.white : Color(0xff909090);
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 40.0,
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
