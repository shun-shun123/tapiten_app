import 'package:flutter/material.dart';

class TopPageStartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: RaisedButton(
        child: Text("はじめる"),
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
