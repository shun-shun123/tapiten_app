import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
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
          answererName: '',
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
  void initState() {
    super.initState();
    Provider.of<FinishSheepViewModel>(context, listen: false)
        .returnMainScreenAction
        .stream
        .listen((_) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<FinishSheepViewModel>(context);

    var rating = 3.0;

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
          Text(
            'レビューをつけよう',
            style: kTitleTextStyle,
          ),
          SmoothStarRating(
              allowHalfRating: false,
              onRated: (value) {
                viewModel.reviewScore = value;
                print('star rate: $value');
              },
              starCount: 5,
              rating: rating,
              size: 40.0,
              isReadOnly: false,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Color(0xff9FD53E),
              borderColor: Color(0xfff7f7f7),
              spacing: 0.0),
          SizedBox(height: 24),
          ReturnMainScreenButton(onPressed: viewModel.returnMainScreen),
        ],
      ),
    );
  }
}
