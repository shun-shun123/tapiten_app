import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/view/message_list_view/empty_message.dart';
import 'package:tapiten_app/view/message_list_view/message_list_view_cell.dart';
import 'package:tapiten_app/view/message_list_view_model/message_list_answers_view_model.dart';

// 神さまモードのListViewを管理するWidget
class MessageListViewForGod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    var messageList = Provider.of<MessageListAnswersViewModel>(context);
    var answers = messageList.answers;
    answers.forEach((answer) {
      cells.add(MessageListViewCell.god(
        answer: answer,
      ));
    });

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: messageList.isBusy
          ? Container()
          : cells.length == 0
              ? EmptyMessage()
              : ListView(
                  children: cells,
                ),
    );
  }
}
