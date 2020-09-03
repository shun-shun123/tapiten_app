import 'package:flutter/material.dart';

class MessageDetailReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const reviewIcons = [
      Icon(Icons.star),
      Icon(Icons.star),
      Icon(Icons.star),
      Icon(Icons.star),
      Icon(Icons.star),
    ];
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text('今回もらった評価'),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: reviewIcons,
            ),
          ),
        ],
      ),
    );
  }
}
