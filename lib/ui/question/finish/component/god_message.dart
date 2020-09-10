import 'package:flutter/material.dart';

class GodMessage extends StatelessWidget {
  final String messageText;

  GodMessage({@required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            color: Color(0xff707070),
          ),
        ),
        color: Colors.white,
        child: Container(
          width: 212,
          height: 90,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                messageText,
                style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 14,
                  fontFamily: 'RictyDiminished-Regular',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
