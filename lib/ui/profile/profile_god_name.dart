import 'package:flutter/material.dart';

class ProfileGodName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Text(
          'マイペースにお腹のすいた神',
          style: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
