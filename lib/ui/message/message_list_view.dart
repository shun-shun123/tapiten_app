import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/message/message_list_cell.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';

class MessageListView extends StatefulWidget {
  final bool isGod;

  MessageListView({this.isGod});

  @override
  _MessageListViewState createState() => _MessageListViewState(isGod: isGod);
}

class _MessageListViewState extends State<MessageListView> {
  final bool isGod;

  _MessageListViewState({this.isGod});

  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    var messageList = Provider.of<MessageList>(context);
    if (isGod) {
      var answers = messageList.answers;
      answers.forEach((answer) {
        cells.add(MessageListCell.god(
          answer: answer,
        ));
      });
    } else {
      var questions = messageList.questions;
      questions.forEach((question) {
        cells.add(MessageListCell.sheep(
          question: question,
        ));
      });
    }
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: ListView(
        children: cells,
      ),
    );
  }
}
