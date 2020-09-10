import 'package:flutter/material.dart';

class ChoiceText extends StatelessWidget {
  ChoiceText({@required this.isSelect, @required this.text});

  final bool isSelect;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: isSelect ? Color(0xff9FD53E) : Color(0xff707070),
        ),
      ),
      color: isSelect ? Color(0xff9FD53E) : Colors.white,
      child: Container(
        width: isSelect ? 164 : 148,
        height: isSelect ? 40 : 32,
        child: Center(
          child: Padding(
            padding: isSelect
                ? EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  )
                : EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelect ? Colors.white : Color(0xff707070),
                fontSize: isSelect ? 14 : 10,
                fontFamily: 'RictyDiminished-Regular',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
