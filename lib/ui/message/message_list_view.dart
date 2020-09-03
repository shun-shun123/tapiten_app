import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/message/message_list_cell.dart';

class MessageListView extends StatefulWidget {
  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    var data = [
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
      MessageListCell(),
    ];
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: ListView(
          children: data,
        ),
      ),
    );
  }
}
