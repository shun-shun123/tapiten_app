import 'package:flutter/material.dart';

class TwoAnswerButtons extends StatelessWidget {
  final answer1;
  final answer2;

  TwoAnswerButtons({this.answer1, this.answer2});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: Column(
          children: [
            AnswerButton(
              text: answer1,
              hasSelected: true,
            ),
            SizedBox(
              height: 15,
            ),
            AnswerButton(
              text: answer2,
              hasSelected: false,
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
  AnswerButton({this.text, this.hasSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: RaisedButton(
        child: Text(text),
        color: hasSelected ? Color(0xFFF8DB25) : Colors.white,
        textColor: Color(0xFF909090),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xFFE8E8E8),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
