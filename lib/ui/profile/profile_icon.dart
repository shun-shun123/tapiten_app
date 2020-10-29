import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/view/profile_icon_edit_page/profile_icon_edit_page.dart';

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (UserMode.isGod) ? AssetImage('images/god.png') : AssetImage('images/sheep.png'),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProfileIconEditPage();
                },
              ),
            );
          },
          child: const Text('変更する'),
          textColor: Color(0xFF909090),
        )
      ],
    );
  }
}
