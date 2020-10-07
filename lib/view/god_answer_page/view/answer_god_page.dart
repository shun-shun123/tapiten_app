import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/view/god_answer_page/view/component/answer_decide_button.dart';
import 'package:tapiten_app/view/god_answer_page/view/component/answer_select_button.dart';
import 'package:tapiten_app/view/god_answer_page/viewmodel/answer_god_view_model.dart';

class AnswerGodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _opponentUserId = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (_) => AnswerGodViewModel(
        _opponentUserId,
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
        body: AnswerGodPageBody(),
      ),
    );
  }
}

class AnswerGodPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AnswerGodViewModel rebuildViewModel =
        Provider.of<AnswerGodViewModel>(context);
    final AnswerGodViewModel nonRebuildViewModel =
        Provider.of<AnswerGodViewModel>(context, listen: false);

    nonRebuildViewModel.answerSuccessAction.stream.listen((_) {
      Navigator.pushReplacementNamed(context, '/finish_god');
    });
    nonRebuildViewModel.getCurrentUser();

    return Scaffold(
      body: Container(
        color: Colors.white,
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
                  image: AssetImage("images/sheep.png"),
                ),
              ),
            ),
            SizedBox(height: 60),
            Text(
              rebuildViewModel.question.questionContent,
              style: TextStyle(
                  color: Color(0xff909090),
                  fontFamily: 'RictyDiminished-Regular',
                  fontSize: 15),
            ),
            SizedBox(height: 42),
            AnswerSelectButton(
              backgroundColor: rebuildViewModel.selectedAnswerIndex == 0
                  ? Color(0xffF8DB25)
                  : Colors.white,
              title: rebuildViewModel.question.answer1,
              onPressed: () => rebuildViewModel.selectAnswer(0),
              borderColor: rebuildViewModel.selectedAnswerIndex == 0
                  ? Color(0xffF8DB25)
                  : Color(0xff909090),
              textColor: Color(0xff909090),
            ),
            AnswerSelectButton(
              backgroundColor: rebuildViewModel.selectedAnswerIndex == 1
                  ? Color(0xffF8DB25)
                  : Colors.white,
              title: rebuildViewModel.question.answer2,
              onPressed: () => rebuildViewModel.selectAnswer(1),
              borderColor: rebuildViewModel.selectedAnswerIndex == 1
                  ? Color(0xffF8DB25)
                  : Color(0xff909090),
              textColor: Color(0xff909090),
            ),
            AnswerDecideButton(
              isSelectAnswer: rebuildViewModel.isSelectAnswer,
              onPressed: rebuildViewModel.isSelectAnswer
                  ? () => rebuildViewModel.onPressAnswerDecideButton()
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
