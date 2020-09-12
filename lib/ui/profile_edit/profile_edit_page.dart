import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile/profile_page.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_icon.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_info.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

import '../../main.dart';
import '../../slide_page_route.dart';

class ProfileEditPage extends StatefulWidget {
  final String initGodName;
  final String initSheepName;
  final String initDisplayId;
  final String initMessage;

  ProfileEditPage(
      {this.initGodName,
      this.initSheepName,
      this.initDisplayId,
      this.initMessage});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileEditViewModel profileEditViewModel;

  @override
  void initState() {
    super.initState();
    profileEditViewModel = new ProfileEditViewModel();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return ChangeNotifierProvider.value(
      value: profileEditViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: (UserMode.isGod) ? Colors.white : Color(0xFF909090),
        appBar: AppBar(
          backgroundColor: (UserMode.isGod) ? Colors.white : Color(0xFF909090),
          title: ProfileEditPageTitle(),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
            ),
            onPressed: () => {
              Navigator.of(context).pop(false),
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              onPressed: () {
                profileEditViewModel.saveProfile();
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSpace),
            child: Container(
              child: Column(children: [
                ProfileEditIcon(),
                ProfileEditInfo(
                  initGodName: this.widget.initGodName,
                  initSheepName: this.widget.initSheepName,
                  initDisplayId: this.widget.initDisplayId,
                  initMessage: this.widget.initMessage,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileEditPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'プロフィール',
      style: kTitleTextStyle.copyWith(
        fontSize: 20,
        color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
      ),
    );
  }
}
