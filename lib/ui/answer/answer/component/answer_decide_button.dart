import 'package:flutter/material.dart';

/*
GodAnswerPage用の選択肢ボタン
*/

class AnswerDecideButton extends StatelessWidget {
  AnswerDecideButton({
    @required this.isSelectAnswer,
    @required this.onPressed,
  });

  final bool isSelectAnswer;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ButtonTheme(
          minWidth: 174,
          height: 38,
          child: RaisedButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: isSelectAnswer ? Color(0xffF8D825) : Color(0xffE8E8E8),
              ),
            ),
            color: isSelectAnswer ? Color(0xffF8D825) : Color(0xffE8E8E8),
            child: Text(
              '決定',
              style: TextStyle(
                color: Color(0xff909090),
                fontFamily: 'RictyDiminished-Regular',
              ),
            ),
          ),
        ));
  }
}
