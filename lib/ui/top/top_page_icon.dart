import 'package:flutter/material.dart';

class TopPageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Image.asset('images/top_image.jpg'),
          ],
        ),
      ),
    );
  }
}
