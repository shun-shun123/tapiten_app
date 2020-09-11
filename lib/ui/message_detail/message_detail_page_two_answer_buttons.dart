import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class TwoAnswerButtons extends StatelessWidget {
  final answer1;
  final answer2;
  final int selectIndex;

  TwoAnswerButtons({this.answer1, this.answer2, this.selectIndex});
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    var activeColor =
        userMode.isGodFlag ? Color(0xFFF8DB25) : Color(0xFF9FD53E);
    var disableColor =
        userMode.isGodFlag ? Color(0xFFE8E8E8) : Color(0xFFFFFFFF);
    print(selectIndex);
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: Column(
          children: [
            AnswerButton(
              text: answer1,
              hasSelected: selectIndex == 0,
              btnColor: selectIndex == 0 ? activeColor : disableColor,
            ),
            SizedBox(
              height: 15,
            ),
            AnswerButton(
              text: answer2,
              hasSelected: selectIndex == 1,
              btnColor: selectIndex == 1 ? activeColor : disableColor,
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String text;
  final bool hasSelected;
  final Color btnColor;
  AnswerButton({this.text, this.hasSelected, this.btnColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: hasSelected ? 200 : 100,
      height: 40,
      child: RaisedButton(
        child: Text(text),
        color: btnColor,
        textColor: Color(0xFF909090),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
