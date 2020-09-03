import 'package:flutter/material.dart';

class TwoAnswerButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: Column(
          children: [
            AnswerButton(
              text: '出る',
              hasSelected: true,
            ),
            SizedBox(
              height: 15,
            ),
            AnswerButton(
              text: '出ない',
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
