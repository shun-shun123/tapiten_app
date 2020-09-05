import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_icon.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_id.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_intro.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_mode_change_button.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_name.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_review_score.dart';

class ProfileGodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'プロフィール',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: ProfileGodPageTitle(),
          ),
          body: Container(
            child: Center(
              child: Column(children: [
                ProfileGodIcon(),
                ProfileGodName(),
                ProfileGodId(),
                ProfileGodIntro(),
                ProfileGodReviewStars(),
                ProfileGodModeChangeButton(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileGodPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'プロフィール',
      style: TextStyle(
        color: Color(0xFF909090),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
