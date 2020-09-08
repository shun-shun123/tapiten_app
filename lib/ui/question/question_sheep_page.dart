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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/sheep.png',
              width: 120,
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '迷いの内容',
                  style: kTitleTextStyle,
                ),
                TextFormField(
                  style: kTextFormFieldTextStyle,
                  decoration: kQuestionTextFormFieldDecoration,
                  maxLines: 8,
                  maxLength: 140,
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  '選択肢1',
                  style: kTitleTextStyle,
                ),
                TextFormField(
                  style: kTextFormFieldTextStyle,
                  decoration: kChoiceTextFormFieldDecoration.copyWith(
                      hintText: '1つ目の選択肢を入力'),
                ),
                SizedBox(height: 18.0),
                Text(
                  '選択肢2',
                  style: kTitleTextStyle,
                ),
                TextFormField(
                  style: kTextFormFieldTextStyle,
                  decoration: kChoiceTextFormFieldDecoration.copyWith(
                      hintText: '2つ目の選択肢を入力'),
                ),
                SizedBox(height: 48),
              ],
            ),
            QuestionDecideButton(
              isFillForm: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

const kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
);

const kTextFormFieldTextStyle = TextStyle(
  color: Color(0xff707070),
);

const kChoiceTextFormFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff707070), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff9FD53E), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kQuestionTextFormFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff707070), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff9FD53E), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
