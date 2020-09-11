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
                color: Color(0xff9FD53E),
              ),
            ),
            color: Color(0xff9FD53E),
            child: Text(
              '終了',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'RictyDiminished-Regular',
                fontSize: 15,
              ),
            ),
          ),
        ));
  }
}
