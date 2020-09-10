import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/ui/question/finish/finish_sheep_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

import 'component/choice_text.dart';
import 'component/god_message.dart';
import 'component/return_main_screen_button.dart';

class FinishSheepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinishSheepViewModel(
        Question(
          answererId: null,
          questionContent: '',
          answer1: '',
          answer2: '',
          godMessage: '',
          selectedAnswerIndex: null,
        ),
      ),
      child: Scaffold(
        body: FinishSheepPageBody(),
      ),
    );
  }
}

class FinishSheepPageBody extends StatefulWidget {
  @override
  _FinishSheepPageBodyState createState() => _FinishSheepPageBodyState();
}

class _FinishSheepPageBodyState extends State<FinishSheepPageBody> {
  FinishSheepViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<FinishSheepViewModel>(context);

    return Container(
      color: Color(0xff909090),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/god.png"),
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            viewModel.question.questionContent,
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28),
          ChoiceText(
              isSelect: viewModel.question.selectedAnswerIndex == 0,
              text: viewModel.question.answer1),
          SizedBox(height: 18),
          ChoiceText(
              isSelect: viewModel.question.selectedAnswerIndex == 1,
              text: viewModel.question.answer2),
          SizedBox(height: 60),
          Text(
            '今回の神さまからの名言',
            style: kTitleTextStyle,
          ),
          GodMessage(messageText: viewModel.question.godMessage),
          SizedBox(height: 42),
          ReturnMainScreenButton(onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          })
        ],
      ),
    );
  }
}
