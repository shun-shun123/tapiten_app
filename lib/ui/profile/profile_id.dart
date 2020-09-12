import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileId extends StatelessWidget {
  final String displayId;

  ProfileId({@required this.displayId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Text(
          displayId,
          style: kTitleTextStyle.copyWith(
            fontSize: 20,
            color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
          ),
        ),
      ),
    );
  }
}
