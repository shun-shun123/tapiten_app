import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileIconEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 実際のXDに合わせてUIを実装する
    return ChangeNotifierProvider(
      create: (context) => null,
      child: Scaffold(
        backgroundColor: Color(0xFF909090),
        appBar: AppBar(
          title: Text('プロフィール'),
          backgroundColor: Color(0xFF909090),
        ),
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
