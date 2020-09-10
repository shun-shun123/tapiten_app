import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapiten_app/storage/user_login_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/top/top_page.dart';
import 'package:tapiten_app/storage/user_id.dart';

class SignOutGoogle extends StatelessWidget {
  final Color color;
  SignOutGoogle({@required this.color});

  Future<TopPage> _handleSignOut() async {
    final _googleSignIn = new GoogleSignIn();
    final _auth = FirebaseAuth.instance;

    await _auth.signOut();

    try {
      await _googleSignIn.signOut();
      UserId.userId = '';
      UserMode.isGod = true;
      UserLoginId.loginId = '';
    } catch (e) {
      print(e);
    }

    print('this value should turn to be null:${_auth.currentUser}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Container(
        margin: EdgeInsets.all(30),
        child: FlatButton(
          child: Text(
            'ログアウト',
            style: new TextStyle(
              fontSize: 18.0,
              color: color,
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
          ),
          onPressed: () {
            _handleSignOut();
            // ログアウトしたらトップへ戻る
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopPage()),
            );
          },
        ),
      ),
    );
  }
}
