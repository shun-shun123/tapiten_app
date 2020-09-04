import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/top/top_page_icon.dart';
import 'package:tapiten_app/ui/top/top_page_start_button.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
          title: 'タイトル',
          home: Scaffold(
              body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopPageIcon(),
                TopPageStartButton(),
              ],
            ),
          ))),
    );
  }
}
