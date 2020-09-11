import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_icon.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_question_text.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_review.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_two_answer_buttons.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_remark.dart';

class MessageDetailPage extends StatelessWidget {
  final bool isGod;
  final Answer answer;
  final Question question;
  final Color bgColor;

  // 神様用のコンストラクタ
  MessageDetailPage.god({this.answer})
      : isGod = true,
        question = null,
        bgColor = Color(0xFFF8D825);

  // 子羊用のコンストラクタ
  MessageDetailPage.sheep({this.question})
      : isGod = false,
        answer = null,
        bgColor = Color(0xff9FD53E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: MessageDetailPageTitle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildBaseBody(isGod ? _buildBodyForGod() : _buildBodyForSheep()),
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
  List<Widget> _buildBodyForGod() {
    return [
      MessageDetailPageIcon(),
      MessageDetailPageQuestionText(content: answer.questionContent),
      TwoAnswerButtons(
        answer1: answer.answer1,
        answer2: answer.answer2,
      ),
      MessageDetailReview(
        reviewScore: answer.reviewScore,
      ),
    ];
  }

  // 子羊モードの時のメッセージ詳細画面作成
  List<Widget> _buildBodyForSheep() {
    return [
      MessageDetailPageIcon(),
      MessageDetailPageQuestionText(content: question.questionContent),
      TwoAnswerButtons(
        answer1: question.answer1,
        answer2: question.answer2,
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
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
