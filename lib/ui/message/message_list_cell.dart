import 'package:flutter/material.dart';

class MessageListCell extends StatelessWidget {
  final title;
  MessageListCell({this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE9E9E9),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          title: Text('Message1'),
          subtitle: Text('Message subtitle'),
          leading: Icon(
            Icons.circle,
            color: Colors.blue[500],
          ),
        ),
      ),
    );
  }
}
