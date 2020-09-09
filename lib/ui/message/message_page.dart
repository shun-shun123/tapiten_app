import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/message/message_list_view.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';

class MessagePage extends StatelessWidget {
  final bool isGod;

  MessagePage({this.isGod});

  @override
  Widget build(BuildContext context) {
    var messageList = MessageList();
    if (UserMode.isGod) {
      messageList.fetchMessageListForGod();
    } else {
      messageList.fetchMessageListForSheep();
    }
    return ChangeNotifierProvider(
      create: (context) => messageList,
      child: Scaffold(
        appBar: AppBar(
          title: MessagePageTitle(),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: MessageListView(
            isGod: isGod,
          ),
        ),
      ),
    );
  }
}

class MessagePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'メッセージ一覧',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
