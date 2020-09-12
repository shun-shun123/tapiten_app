import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileName extends StatelessWidget {
  final String godName;
  final String sheepName;

  ProfileName({@required this.godName, @required this.sheepName});

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          (UserMode.isGod) ? godName : sheepName,
          style: kTitleTextStyle.copyWith(
            fontSize: 20,
            color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
          ),
        ),
      ),
    );
  }
}
