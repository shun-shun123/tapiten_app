import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_cell_view_model.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_icon.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_question_text.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_review.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page_two_answer_buttons.dart';

class MessageDetailPage extends StatelessWidget {
  final Answer answer;

  MessageDetailPage({this.answer});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'メッセージ',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: MessageDetailPageTitle(),
          ),
          body: SafeArea(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MessageDetailPageIcon(),
                    MessageDetailPageQuestionText(
                        content: answer.questionContent),
                    TwoAnswerButtons(
                      answer1: answer.answerChoise1,
                      answer2: answer.answerChoise2,
                    ),
                    MessageDetailReview(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
