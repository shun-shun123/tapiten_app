import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/slide_page_route.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile/profile_icon.dart';
import 'package:tapiten_app/ui/profile/profile_id.dart';
import 'package:tapiten_app/ui/profile/profile_message.dart';
import 'package:tapiten_app/ui/profile/profile_mode_change_button.dart';
import 'package:tapiten_app/ui/profile/profile_name.dart';
import 'package:tapiten_app/ui/profile/profile_review_score.dart';
import 'package:tapiten_app/ui/profile/viewModel/profile_user_mode_view_model.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_page.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

String godName;
String sheepName;
String displayId;
String message;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  child: ProfileEditPage(
                    initGodName: godName,
                    initSheepName: sheepName,
                    initDisplayId: displayId,
                    initMessage: message,
                  ),
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

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    godName = (viewModel.godName != null) ? viewModel.godName : '';
    sheepName = (viewModel.sheepName != null) ? viewModel.sheepName : '';
    displayId = (viewModel.displayId != null) ? viewModel.displayId : '';
    message = (viewModel.message != null) ? viewModel.message : '';

    var userMode = Provider.of<UserMode>(context);
    return userMode.isGodFlag ? ProfileGodBody() : ProfileSheepBody();
  }
}

class ProfileGodBody extends StatefulWidget {
  @override
  _ProfileGodBodyState createState() => _ProfileGodBodyState();
}

class _ProfileGodBodyState extends State<ProfileGodBody> {
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

class ProfileSheepBody extends StatefulWidget {
  @override
  _ProfileSheepBodyState createState() => _ProfileSheepBodyState();
}

class _ProfileSheepBodyState extends State<ProfileSheepBody> {
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
