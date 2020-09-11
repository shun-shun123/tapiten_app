import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile/viewModel/profile_user_mode_view_model.dart';

class ProfileModeChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    return Container(
      child: Center(
        child: SizedBox(
          width: 175,
          child: RaisedButton(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    userMode.isGodFlag ? '子羊モード' : '神様モード',
                    style: TextStyle(
                      color: Color(0xFF909090),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
              ],
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              userMode.saveUserMode(isGod: !userMode.isGodFlag);
            },
          ),
        ),
      ),
    );
  }
}
