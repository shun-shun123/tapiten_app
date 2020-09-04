import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/message/message_list_cell.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';

class MessageListView extends StatefulWidget {
  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    var messageList = Provider.of<MessageList>(context)?.answers;
    var data = <Widget>[];
    if (messageList != null) {
      for (var i = 0; i < messageList.length; i++) {
        Widget widget = MessageListCell(
          answer: messageList[i],
        );
        data.add(widget);
      }
    }
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
