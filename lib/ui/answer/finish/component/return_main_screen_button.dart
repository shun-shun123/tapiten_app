import 'package:flutter/material.dart';

class ReturnMainScreenButton extends StatelessWidget {
  ReturnMainScreenButton({@required this.onPressed});

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
              color: Color(0xffF8D825),
            ),
          ),
          color: Color(0xffF8D825),
          child: Text(
            '戻る',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff909090),
              fontFamily: 'RictyDiminished-Regular',
            ),
          ),
        ),
      ),
    );
  }
}
