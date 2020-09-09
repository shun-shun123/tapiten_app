import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapiten_app/ui/top/top_page.dart';
import 'package:tapiten_app/storage/user_id.dart';

class SignOutGoogle extends StatelessWidget {
  final _googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future _handleSignOut() async {
    await _auth.signOut();
    try {
      await _googleSignIn.signOut();
      UserId.userId = '';
    } catch (e) {
      print(e);
    }
    // ログアウトしたらトップへ戻る
    return TopPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('ログアウト', style: new TextStyle(fontSize: 18.0, color: Colors.red)),
        onPressed: () {
          _handleSignOut().catchError((e) => print(e));
        },
      ),
    );
  }
}
