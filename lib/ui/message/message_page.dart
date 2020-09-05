import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/message/message_list_view.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_view_model.dart';

class MessagePage extends StatelessWidget {
  final bool isGod;

  MessagePage({this.isGod});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => isGod
          ? MessageList.god(answers: []) // 神様用の初期化
          : MessageList.sheep(questions: []), // 子羊用の初期化
      child: MaterialApp(
        title: 'メッセージ一覧',
        home: Scaffold(
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
