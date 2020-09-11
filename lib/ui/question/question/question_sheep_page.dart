import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/question/question/component/question_decide_button.dart';
import 'package:tapiten_app/ui/question/question/question_sheep_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_form_field_decoration.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class QuestionSheepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionSheepViewModel(),
      child: Scaffold(
        backgroundColor: Color(0xff909090),
        body: QuestionSheepPageBody(),
      ),
    );
  }
}

class QuestionSheepPageBody extends StatefulWidget {
  @override
  _QuestionSheepPageBodyState createState() => _QuestionSheepPageBodyState();
}

class _QuestionSheepPageBodyState extends State<QuestionSheepPageBody> {
  QuestionSheepViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<QuestionSheepViewModel>(context, listen: false);
    viewModel.questionSuccessAction.stream.listen((_) {
      Navigator.of(context).pushNamed('/matching_sheep');
    });

    viewModel.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        viewModel.checkFillForm();
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
                  'images/sheep_circle.png',
                  width: 120,
                ),
                SizedBox(height: 30),
                Form(
                  key: viewModel.form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '迷い',
                        style: kTitleTextStyle,
                      ),
                      TextFormField(
                        style: kTextFormFieldTextStyle,
                        decoration: kQuestionTextFormFieldDecoration.copyWith(
                            hintText: '迷いを入力'),
                        maxLines: 8,
                        maxLength: 140,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          viewModel.checkFillForm();
                        },
                        onSaved: (value) {
                          viewModel.questionText = value;
                        },
                        onEditingComplete: viewModel.checkFillForm,
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
                          viewModel.firstChoiceText = value;
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          viewModel.checkFillForm();
                        },
                        onEditingComplete: viewModel.checkFillForm,
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
                          viewModel.checkFillForm();
                        },
                        onSaved: (value) {
                          viewModel.secondChoiceText = value;
                        },
                        onEditingComplete: viewModel.checkFillForm,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48),
                QuestionDecideButton(
                  isFillForm: viewModel.isFillForm,
                  onPressed: viewModel.onPressDecideButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
