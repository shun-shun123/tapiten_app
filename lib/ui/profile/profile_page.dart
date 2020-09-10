import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/slide_page_route.dart';
import 'package:tapiten_app/ui/profile/profile_icon.dart';
import 'package:tapiten_app/ui/profile/profile_id.dart';
import 'package:tapiten_app/ui/profile/profile_message.dart';
import 'package:tapiten_app/ui/profile/profile_mode_change_button.dart';
import 'package:tapiten_app/ui/profile/profile_name.dart';
import 'package:tapiten_app/ui/profile/profile_review_score.dart';
import 'package:tapiten_app/ui/profile/viewModel/profile_user_mode_view_model.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_page.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileUserMode()),
        ChangeNotifierProvider(create: (_) => ProfileEditViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ProfilePageTitle(),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.of(context).push(SlidePageRoute(
                  child: ProfileEditPage(),
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

class ProfilePageTitle extends StatelessWidget {
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
      ProfileIcon(),
      ProfileName(),
      ProfileId(),
      ProfileMessage(),
      ProfileReviewStars(),
      ProfileModeChangeButton(),
    ]);
  }
}

class ProfileSheepBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild ProfileGodBody');
    return Column(
      children: [
        ProfileIcon(),
        ProfileName(),
        ProfileId(),
        ProfileReviewStars(),
        ProfileModeChangeButton(),
      ],
    );
  }
}
