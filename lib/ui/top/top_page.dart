import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/top/top_page_icon.dart';
import 'package:tapiten_app/ui/login/sign_in_with_google.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: 'タイトル',
        home: Scaffold(
          body: Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopPageIcon(),
                  SignInWithGoogleButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
