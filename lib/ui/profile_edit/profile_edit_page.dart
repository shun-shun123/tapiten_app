import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_icon.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_info.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

class ProfileEditPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    var profileEditViewModel = new ProfileEditViewModel();

    return ChangeNotifierProvider.value(
      value: profileEditViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ProfileEditPageTitle(),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {
              Navigator.of(context).pop(),
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () => {
                profileEditViewModel.saveProfile(),
                Navigator.of(context).pop(),
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
                  initGodName: this.initGodName,
                  initSheepName: this.initSheepName,
                  initDisplayId: this.initDisplayId,
                  initMessage: this.initMessage,
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
      style: TextStyle(
        color: Color(0xFF909090),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
