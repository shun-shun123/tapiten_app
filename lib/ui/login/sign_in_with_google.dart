import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapiten_app/main.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/ui/login/login_page.dart';
import 'package:tapiten_app/ui/my_home/my_home_page.dart';

class SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: SigninWithGoogle(),
            )
          ],
        ),
      ),
    );
  }
}

class SigninWithGoogle extends StatefulWidget {
  @override
  _SigninWithGoogleState createState() => _SigninWithGoogleState();
}

class _SigninWithGoogleState extends State<SigninWithGoogle> {
  final _googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _buildGoogleSignInButton()),
    );
  }

  // ログイン成功時にログインユーザを返す
  Future<User> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final User user = (await _auth.signInWithCredential(credential)).user;
    await UserId().saveUserId(id: user.uid);
    return user;
  }

  // Google SignIn に成功したら Login ページに飛ぶ
  void transitionNextPage(User user) {
    if (user == null) return;

    // アカウントがすでに存在してるなら ID 入力飛ばす
    print('ユーザID: ${UserId.userId}');
    alreadyHasAccount(UserId.userId).then(
      (value) => value
      ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()))
      : Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  // アカウントがすでに存在しているかの確認
  Future<bool> alreadyHasAccount(String userId) async {
    var flag = true;
    await FirebaseFirestore.instance
        .collection('user_info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.data() != null) {
        flag = true;
      } else {
        flag = false;
      }
    });

    return flag;
  }

  // ボタン
  Widget _buildGoogleSignInButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: ButtonTheme(
            buttonColor: Colors.grey,
            minWidth: 300.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: RaisedButton(
              child: Text(
                "Googleではじめる",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RictyDiminished-Regular',
                    fontSize: 18),
              ),
              onPressed: () {
                _handleGoogleSignIn().then((user) {
                  setState(() {
                    transitionNextPage(user);
                  });
                }).catchError((error) {
                  print(error);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
