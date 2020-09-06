import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/profile_god_edit/profile_god_edit_info.dart';
import 'package:tapiten_app/ui/profile_god_edit/profile_got_edit_icon.dart';

class ProfileGodEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'プロフィール',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: ProfileGodEditPageTitle(),
          ),
          body: Container(
            child: Column(children: [
              ProfileGodEditIcon(),
              ProfileGodEditInfo(),
            ]),
          ),
        ),
      ),
    );
  }
}

class ProfileGodEditPageTitle extends StatelessWidget {
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
