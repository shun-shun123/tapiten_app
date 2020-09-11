import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/message/message_list_cell.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class MessageListView extends StatefulWidget {
  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    var cells = <Widget>[];
    var messageList = Provider.of<MessageList>(context);
    if (userMode.isGodFlag) {
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
      color: userMode.isGodFlag ? Colors.white : Color(0xff909090),
      margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: cells.length == 0
          ? EmptyMessage()
          : ListView(
              children: cells,
            ),
    );
  }
}

class EmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Center(
        child: userMode.isGodFlag
            ? Text(
                '迷える仔羊の悩みを解決しましょう',
                style: kTitleTextStyle.copyWith(
                  color: Color(0xff90909090),
                  fontSize: 18,
                ),
              )
            : Text(
                '迷いを神さまに質問しましょう',
                style: kTitleTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}
