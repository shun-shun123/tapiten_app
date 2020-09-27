import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/view/message_list_page/message_list_view/empty_message.dart';
import 'package:tapiten_app/view/message_list_page/message_list_view/message_list_view_cell.dart';
import 'package:tapiten_app/view/message_list_view_model/message_list_questions_view_model.dart';

// 仔羊モード用のListViewを管理するWidget
class MessageListViewForSheep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cells = <Widget>[];
    var messageList = Provider.of<MessageListQuestionsViewModel>(context);
    var questions = messageList.questions;
    questions.forEach((question) {
      cells.add(MessageListViewCell.sheep(
        question: question,
      ));
    });

    return Container(
      color: Color(0xFF909090),
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
