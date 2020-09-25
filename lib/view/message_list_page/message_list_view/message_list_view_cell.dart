import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/view/message_list_detail_page/view/message_detail_page.dart';

// メッセージ一覧画面で使用するListViewのCellWidget
class MessageListViewCell extends StatelessWidget {
  final Answer answer;
  final Question question;

  // 神さまモード用のCell生成コンストラクタ
  MessageListViewCell.god({this.answer}) : question = null;

  // 仔羊モード用のCell生成コンストラクタ
  MessageListViewCell.sheep({this.question}) : answer = null;

  @override
  Widget build(BuildContext context) {
    // UserMode取得
    var userMode = Provider.of<UserMode>(context);

    // 神さまモード用のCell生成
    if (userMode.isGodFlag) {
      return _buildCellForGod(context);
    }

    // 仔羊モード用のCell生成
    return _buildCellForSheep(context);
  }

  // 神さまモード用のCell生成関数
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

  // 仔羊モード用のCell生成関数
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

// 神さま・仔羊モード両方で使用するCellのベースクラス
// 共通部分はこのクラスで管理している
class BaseCard extends StatelessWidget {
  final bool isGod;
  final String title;
  final String subTitle;
  final GestureTapCallback onTap;

  // モード間で異なるデータはコンストラクタを使用してセットする
  BaseCard({
    @required this.isGod,
    @required this.title,
    @required this.subTitle,
    @required this.onTap,
  });

  // Card.Titleの生成
  Text _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFF909090),
        fontFamily: "RictyDiminished-Regular",
        fontSize: 18,
      ),
    );
  }

  // Card.subTitleの生成
  Text _buildSubTitle() {
    return Text(
      subTitle,
      style: TextStyle(
        color: Color(0xFF909090),
        fontFamily: "RictyDiminished-Regular",
        fontSize: 14,
      ),
    );
  }

  // Card.leadingの生成
  Container _buildLeading() {
    return Container(
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
    );
  }

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
          title: _buildTitle(),
          subtitle: _buildSubTitle(),
          leading: _buildLeading(),
          onTap: onTap,
        ),
      ),
    );
  }
}
