import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileMessage extends StatelessWidget {
  final String messageText;

  ProfileMessage({@required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Column(
          children: [
            Text(
              'あなたの名言',
              style: kTitleTextStyle.copyWith(
                fontSize: 15,
                color: Color(0xFF909090),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              messageText,
              textAlign: TextAlign.center,
              style: kTitleTextStyle.copyWith(
                fontSize: 20,
                color: Color(0xFF909090),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
