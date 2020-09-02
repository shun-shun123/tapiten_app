import 'package:flutter/material.dart';

class TopPageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 350, bottom: 200),
        child: Center(child: Image.asset('images/top_image.jpg')));
  }
}
