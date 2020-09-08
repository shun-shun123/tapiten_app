import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 60),
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
