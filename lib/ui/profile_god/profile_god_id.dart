import 'package:flutter/material.dart';

class ProfileGodId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ID',
              style: TextStyle(
                color: Color(0XFF909090),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '@tapiten',
              style: TextStyle(
                color: Color(0xFF909090),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
