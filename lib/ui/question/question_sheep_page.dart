import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/question/question_decide_button.dart';

class QuestionSheepPage extends StatefulWidget {
  @override
  _QuestionSheepPageState createState() => _QuestionSheepPageState();
}

class _QuestionSheepPageState extends State<QuestionSheepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff909090),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/sheep.png',
            width: 76,
          ),
          Text('迷いの内容'),
          TextFormField(),
          Text('選択肢1'),
          TextFormField(),
          Text('選択肢2'),
          TextFormField(),
          QuestionDecideButton(
            isFillForm: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
