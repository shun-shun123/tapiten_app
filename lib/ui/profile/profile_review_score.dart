import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileReviewScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            ProfileReviewStars(),
          ],
        ),
      ),
    );
  }
}

class ProfileReviewStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Text(
            '神さまランク',
            style: kTitleTextStyle.copyWith(
              fontSize: 15,
              color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              Icon(
                Icons.star,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              Icon(
                Icons.star,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              Icon(
                Icons.star,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              Icon(
                Icons.star,
                color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
              ),
              Text(
                ' 3.0',
                style: kTitleTextStyle.copyWith(
                  fontSize: 20,
                  color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
