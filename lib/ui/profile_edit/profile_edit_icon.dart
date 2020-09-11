import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class ProfileEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 100,
          bottom: (UserMode.isGod) ? 80 : 130,
        ),
        child: Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (UserMode.isGod)
                  ? AssetImage('images/god.png')
                  : AssetImage('images/sheep.png'),
            ),
          ),
        ));
  }
}
