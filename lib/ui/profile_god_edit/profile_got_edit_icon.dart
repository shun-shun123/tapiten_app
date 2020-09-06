import 'package:flutter/material.dart';

class ProfileGodEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 5),
      child: Center(
        child: Icon(
          Icons.account_circle,
          color: Colors.black,
          size: 100,
        ),
      ),
    );
  }
}
