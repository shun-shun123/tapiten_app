import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/message/message_list_view.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var messageList = MessageList();
    var userMode = Provider.of<UserMode>(context);
    if (userMode.isGodFlag) {
      messageList.fetchMessageListForGod();
    } else {
      messageList.fetchMessageListForSheep();
    }
    return ChangeNotifierProvider(
      create: (context) => messageList,
      child: Scaffold(
        backgroundColor: userMode.isGodFlag ? Colors.white : Color(0xff909090),
        appBar: AppBar(
          title: MessagePageTitle(),
          backgroundColor: userMode.isGodFlag ? Colors.white : Color(0xff909090),
        ),
        body: SafeArea(
          child: MessageListView(),
        ),
      ),
    );
  }
}

class MessagePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    return Text(
      'メッセージ一覧',
      style: TextStyle(
        color: userMode.isGodFlag ? Color(0xff909090) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
