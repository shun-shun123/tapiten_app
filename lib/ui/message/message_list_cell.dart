import 'package:flutter/material.dart';

class MessageListCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE9E9E9),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.white,
              size: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text('Message1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
