import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/slide_page_route.dart';
import 'package:tapiten_app/ui/profile/profile_god_icon.dart';
import 'package:tapiten_app/ui/profile/profile_god_id.dart';
import 'package:tapiten_app/ui/profile/profile_god_intro.dart';
import 'package:tapiten_app/ui/profile/profile_god_mode_change_button.dart';
import 'package:tapiten_app/ui/profile/profile_god_name.dart';
import 'package:tapiten_app/ui/profile/profile_god_review_score.dart';
import 'package:tapiten_app/ui/profile/viewModel/profile_user_mode_view_model.dart';
import 'package:tapiten_app/ui/profile_god_edit/profile_god_edit_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileUserMode(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ProfileGodPageTitle(),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.of(context).push(SlidePageRoute(
                  child: ProfileGodEditPage(),
                ))
              },
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: ProfileBody(),
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

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profileMode = Provider.of<ProfileUserMode>(context);
    return profileMode.userMode ? ProfileGodBody() : ProfileSheepBody();
  }
}

class ProfileGodBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild ProfileGodBody');
    return Column(children: [
      ProfileGodIcon(),
      ProfileGodName(),
      ProfileGodId(),
      ProfileGodIntro(),
      ProfileGodReviewStars(),
      ProfileGodModeChangeButton(),
    ]);
  }
}

class ProfileSheepBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild ProfileGodBody');
    return Column(
      children: [
        ProfileGodIcon(),
        ProfileGodName(),
        ProfileGodId(),
        ProfileGodReviewStars(),
        ProfileGodModeChangeButton(),
      ],
    );
  }
}
