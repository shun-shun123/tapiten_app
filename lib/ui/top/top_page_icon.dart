import 'package:flutter/material.dart';

class TopPageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      child: SafeArea(
        child: Column(
          children: [
            Image.asset('images/top_logo.png'),
          ],
        ),
      ),
    );
  }
}
