import 'package:flutter/material.dart';

class MessageDetailPageQuestionText extends StatelessWidget {
  final String content;
  MessageDetailPageQuestionText({this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF909090),
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
