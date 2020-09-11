import 'package:flutter/material.dart';

/*
GodAnswerPage用の選択肢ボタン
*/

class AnswerSelectButton extends StatelessWidget {
  AnswerSelectButton(
      {@required this.backgroundColor,
      @required this.title,
      @required this.onPressed,
      @required this.borderColor,
      @required this.textColor});

  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String title;
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
                color: borderColor,
              ),
            ),
            color: backgroundColor,
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontFamily: 'RictyDiminished-Regular',
              ),
            ),
          ),
        ));
  }
}
