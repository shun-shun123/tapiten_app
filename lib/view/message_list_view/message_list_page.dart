import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/view/message_list_view/message_list_view_for_god.dart';
import 'package:tapiten_app/view/message_list_view/message_list_view_for_sheep.dart';
import 'package:tapiten_app/view/message_list_view_model/message_list_answers_view_model.dart';
import 'package:tapiten_app/view/message_list_view_model/message_list_questions_view_model.dart';

import 'message_list_page_title.dart';

// メッセージ一覧画面のルートWidget
class MessageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserModeの取得
    var userMode = Provider.of<UserMode>(context);

    // 神さまモードのView生成
    if (userMode.isGodFlag) {
      return MessageListPageForGod();
    }

    // 仔羊モードのView生成
    return MessageListPageForSheep();
  }
}

// 神さまモードのメッセージ一覧画面のViewを生成する
class MessageListPageForGod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // メッセージViewModelの生成
    var messageList = MessageListAnswersViewModel();
    messageList.fetchMessageAnswersList();

    return ChangeNotifierProvider(
      create: (context) => messageList,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: MessagePageTitle(),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: MessageListViewForGod(),
        ),
      ),
    );
  }
}

// 仔羊モードのメッセージ一覧画面のViewを生成する
class MessageListPageForSheep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // メッセージViewModelの生成
    var messageList = MessageListQuestionsViewModel();
    messageList.fetchMessageQuestionsList();

    return ChangeNotifierProvider(
      create: (context) => messageList,
      child: Scaffold(
        backgroundColor: Color(0xFF909090),
        appBar: AppBar(
          title: MessagePageTitle(),
          backgroundColor: Color(0xFF909090),
        ),
        body: SafeArea(
          child: MessageListViewForSheep(),
        ),
      ),
    );
  }
}
