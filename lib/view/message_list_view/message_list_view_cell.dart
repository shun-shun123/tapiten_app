import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page.dart';

class MessageListViewCell extends StatelessWidget {
  final Answer answer;
  final Question question;

  MessageListViewCell.god({this.answer}) : question = null;
  MessageListViewCell.sheep({this.question}) : answer = null;

  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    if (userMode.isGodFlag) {
      return _buildCellForGod(context);
    }
    return _buildCellForSheep(context);
  }

  Widget _buildCellForGod(BuildContext context) {
    return BaseCard(
      isGod: true,
      title: answer.questionerName,
      subTitle: answer.questionContent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MessageDetailPage.god(
                answer: answer,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCellForSheep(BuildContext context) {
    return BaseCard(
      isGod: false,
      title: question.answererName,
      subTitle: question.questionContent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MessageDetailPage.sheep(
                question: question,
              );
            },
          ),
        );
      },
    );
  }
}

class BaseCard extends StatelessWidget {
  final bool isGod;
  final String title;
  final String subTitle;
  final GestureTapCallback onTap;

  BaseCard({
    @required this.isGod,
    @required this.title,
    @required this.subTitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: isGod ? Color(0xFFe8e8e8) : Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFF909090),
              fontFamily: "RictyDiminished-Regular",
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              color: Color(0xFF909090),
              fontFamily: "RictyDiminished-Regular",
              fontSize: 14,
            ),
          ),
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: isGod ? AssetImage("images/god.png") : AssetImage("images/sheep.png"),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
