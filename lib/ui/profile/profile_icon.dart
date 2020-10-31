import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/profile_god_icon_model.dart';
import 'package:tapiten_app/storage/profile_sheep_icon_model.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/view/profile_icon_edit_page/profile_icon_edit_page.dart';

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profileIconGod = Provider.of<ProfileGodIconModel>(context);
    var profileIconSheep = Provider.of<ProfileSheepIconModel>(context);
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
              image: (UserMode.isGod)
                  ? AssetImage('images/profile_icons/${ProfileGodIconModel.resourceId}')
                  : AssetImage('images/profile_icons/${ProfileSheepIconModel.resourceId}'),
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
