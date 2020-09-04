import 'package:flutter/material.dart';

class ProfileGodReviewScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            ProfileGodReviewStars(),
          ],
        ),
      ),
    );
  }
}

class ProfileGodReviewStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          ),
          Text(
            '3.0',
            style: TextStyle(
              color: Color(0xFF909090),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
