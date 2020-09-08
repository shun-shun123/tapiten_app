import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_icon.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_info.dart';

class ProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return MultiProvider(
      providers: [],
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
                // TODO: ここでプロフィールの保存処理を行いたい
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
                ProfileEditInfo(),
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
