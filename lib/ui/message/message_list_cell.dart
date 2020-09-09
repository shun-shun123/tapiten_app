import 'package:flutter/material.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page.dart';

class MessageListCell extends StatelessWidget {
  final bool isGod;
  final Answer answer;
  final Question question;

  // 神様用のコンストラクタ
  MessageListCell.god({this.answer})
      : isGod = true,
        question = null;

  // 子羊用のコンストラクタ
  MessageListCell.sheep({this.question})
      : isGod = false,
        answer = null;

  @override
  Widget build(BuildContext context) {
    if (isGod)
      return _buildCardForGod(context);
    else
      return _buildCardForSheep(context);
  }

  Widget _buildCardForGod(BuildContext context) {
    return _buildBaseCard(
      Text(answer.questionContent),
      Icon(Icons.settings),
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          // メッセージ詳細画面（神様モード）に遷移する
          return MessageDetailPage.god(
            answer: answer,
          );
        }));
      },
    );
  }

  Widget _buildCardForSheep(BuildContext context) {
    return _buildBaseCard(
      Text(question.questionContent),
      Icon(Icons.settings),
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          // メッセージ詳細画面（子羊モード）に遷移する
          return MessageDetailPage.sheep(
            question: question,
          );
        }));
      },
    );
  }

  Widget _buildBaseCard(
    Text title,
    Icon icon,
    GestureTapCallback onTap,
  ) {
    return Card(
      color: Color(0xFFE9E9E9),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          title: title,
          leading: icon,
          onTap: onTap,
        ),
      ),
    );
  }
}
