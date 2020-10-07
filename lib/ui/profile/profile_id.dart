import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_login_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';
import 'package:tapiten_app/ui/top/top_page.dart';

class ProfileId extends StatelessWidget {
  final String displayId;

  ProfileId({@required this.displayId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayId,
            style: kTitleTextStyle.copyWith(
              fontSize: 20,
              color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
            ),
          ),
          IconButton(
            icon: UserMode.isGod
                ? new Image.asset("images/logout_gray.png")
                : new Image.asset("images/logout_white.png"),
            onPressed: () async {
              var auth = FirebaseAuth.instance;
              if (auth != null) {
                await auth.signOut();
              }
              var googleSignout = new GoogleSignIn();
              await googleSignout.signOut();
              UserId.userId = '';
              UserMode.isGod = true;
              UserLoginId.loginId = '';
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
