import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapiten_app/ui/login/login_page.dart';

class SignInWithGooglePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Container(
      child: Scaffold(
        appBar: AppBar(title: new Text("Firebase Google ログイン")),
        body: SiginWithGoogle(),
      ),
    );
  }
}

class SiginWithGoogle extends StatefulWidget {
  @override
  _SiginWithGoogleState createState() => _SiginWithGoogleState();
}

class _SiginWithGoogleState extends State<SiginWithGoogle> {
  FirebaseUser _user;
  final _googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _buildGoogleSignInButton()),
    );
  }

  // ログイン処理
  Future<FirebaseUser> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final user = authResult.user;

    print("------------------");
    print(authResult);
    print("------------------");

    return user;
  }

  // Google SignIn に成功したら Login ページに飛ぶ
  void transitionNextPage(FirebaseUser user) {
    if (user == null) return;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  // ボタン
  Widget _buildGoogleSignInButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RaisedButton(
            child: Text("Google Sign In"),
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
