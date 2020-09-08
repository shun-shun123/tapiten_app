import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/question/question_decide_button.dart';
import 'package:tapiten_app/ui/question/styles/text_form_field_decoration.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class QuestionSheepPage extends StatefulWidget {
  @override
  _QuestionSheepPageState createState() => _QuestionSheepPageState();
}

class _QuestionSheepPageState extends State<QuestionSheepPage> {
  final _form = GlobalKey<FormState>();
  String questionText;
  String firstChoiceText;
  String secondChoiceText;
  bool _isFillForm = false;

  void checkFillForm() {
    _form.currentState.save();
    setState(() {
      _isFillForm = questionText.isNotEmpty &&
              firstChoiceText.isNotEmpty &&
              secondChoiceText.isNotEmpty
          ? true
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff909090),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          checkFillForm();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'images/sheep.png',
                    width: 120,
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _form,
                    child: Column(
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
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            checkFillForm();
                          },
                          onSaved: (value) {
                            questionText = value;
                          },
                          onEditingComplete: checkFillForm,
                        ),
                        SizedBox(height: 28),
                        Text(
                          '選択肢1',
                          style: kTitleTextStyle,
                        ),
                        TextFormField(
                          style: kTextFormFieldTextStyle,
                          decoration: kChoiceTextFormFieldDecoration.copyWith(
                              hintText: '1つ目の選択肢を入力'),
                          onSaved: (value) {
                            firstChoiceText = value;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            checkFillForm();
                          },
                          onEditingComplete: checkFillForm,
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
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            checkFillForm();
                          },
                          onSaved: (value) {
                            secondChoiceText = value;
                          },
                          onEditingComplete: checkFillForm,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48),
                  QuestionDecideButton(
                    isFillForm: _isFillForm,
                    onPressed: () {
                      _form.currentState.save();
                      print(questionText);
                      print(firstChoiceText);
                      print(secondChoiceText);
                      Navigator.of(context).pushNamed('/matching_sheep');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
