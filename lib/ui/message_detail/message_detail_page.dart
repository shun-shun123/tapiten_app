import 'package:flutter/material.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_icon.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_question_text.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_review.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_two_answer_buttons.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_remark.dart';

class MessageDetailPage extends StatelessWidget {
  final bool isGod;
  final Answer answer;
  final Question question;
  final Color screenBackgroundColor;
  final Color cardBackgroundColor;

  // 神様用のコンストラクタ
  MessageDetailPage.god({this.answer})
      : isGod = true,
        question = null,
        screenBackgroundColor = Colors.white,
        cardBackgroundColor = Color(0xffe8e8e8);

  // 子羊用のコンストラクタ
  MessageDetailPage.sheep({this.question})
      : isGod = false,
        answer = null,
        screenBackgroundColor = Color(0xff909090),
        cardBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      appBar: AppBar(
        backgroundColor: screenBackgroundColor,
        title: MessageDetailPageTitle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: UserMode.isGod ? Color(0xff909090) : Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Card(
        margin:
            EdgeInsets.only(top: 15.0, bottom: 100.0, left: 15.0, right: 15.0),
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: _buildBaseBody(isGod
            ? _buildBodyForGod(answer.selectedAnswerIndex)
            : _buildBodyForSheep(question.selectedAnswerIndex)),
      ),
    );
  }

  // セーフエリアとかColumnとか諸々考慮したベースwidgetを作成する
  Widget _buildBaseBody(List<Widget> children) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  // 神様モードの時のメッセージ詳細画面作成
  List<Widget> _buildBodyForGod(int selectedIndex) {
    return [
      MessageDetailPageIcon(),
      MessageDetailPageQuestionText(content: answer.questionContent),
      TwoAnswerButtons(
        answer1: answer.answer1,
        answer2: answer.answer2,
        selectIndex: selectedIndex,
      ),
      MessageDetailReview(
        reviewScore: answer.reviewScore,
      ),
    ];
  }

  // 子羊モードの時のメッセージ詳細画面作成
  List<Widget> _buildBodyForSheep(int selectedIndex) {
    return [
      MessageDetailPageIcon(),
      MessageDetailPageQuestionText(content: question.questionContent),
      TwoAnswerButtons(
        answer1: question.answer1,
        answer2: question.answer2,
        selectIndex: selectedIndex,
      ),
      MessageDetailRemark(
        remark: question.godMessage,
      ),
    ];
  }
}

class MessageDetailPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'メッセージ',
      style: TextStyle(
        color: UserMode.isGod ? Color(0xff909090) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
