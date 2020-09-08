import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tapiten_app/main.dart';

class SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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

    return user;
  }

  // Google SignIn に成功したら Login ページに飛ぶ
  void transitionNextPage(User user) {
    if (user == null) return;
    // TODO: リダイレクト先の入力項目は要調整
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  // ボタン
  Widget _buildGoogleSignInButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RaisedButton(
            child: Text("Googleではじめる"),
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
      ],
    );
  }
}
