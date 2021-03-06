import 'package:flutter/material.dart';

class MessageDetailReview extends StatelessWidget {
  final int reviewScore;

  MessageDetailReview({this.reviewScore});

  @override
  Widget build(BuildContext context) {
    var reviewIcons = <Widget>[
      for (int i = 0; i < 5; i++)
        Icon(
          Icons.star,
          color:
              i < reviewScore.toInt() ? Color(0xFF909090) : Color(0XFFFFFFFF),
        )
    ];
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            '今回もらった評価',
            style: TextStyle(
              fontFamily: 'RictyDiminished-Regular',
              color: Color(0xff909090),
            ),
          ),
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
