import 'package:flutter/material.dart';

/*
GodAnswerPage用の選択肢ボタン
*/

class QuestionDecideButton extends StatelessWidget {
  QuestionDecideButton({
    @required this.isFillForm,
    @required this.onPressed,
  });

  final bool isFillForm;
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
                color: isFillForm ? Color(0xff9FD53E) : Color(0xffffffff),
              ),
            ),
            color: isFillForm ? Color(0xff9FD53E) : Color(0xff909090),
            child: Text(
              '決定',
              style: TextStyle(
                color: Color(0xffffffff),
              ),
            ),
          ),
        ));
  }
}
