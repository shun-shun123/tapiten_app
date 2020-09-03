import 'package:flutter/material.dart';

class TopPageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Image.asset('images/top_image.jpg'),
      ],
    ));
  }
}
