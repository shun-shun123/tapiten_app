import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/answer/component/answer_decide_button.dart';
import 'package:tapiten_app/ui/answer/component/answer_select_button.dart';

class AnswerGodPage extends StatefulWidget {
  @override
  _AnswerGodPageState createState() => _AnswerGodPageState();
}

class _AnswerGodPageState extends State<AnswerGodPage> {
  int _selectedAnswerIndex;
  bool _isSelectAnswer = false;

  void selectAnswer(int selectedAnswerIndex) {
    setState(() {
      _selectedAnswerIndex = _selectedAnswerIndex != selectedAnswerIndex
          ? selectedAnswerIndex
          : null;

      _isSelectAnswer = _selectedAnswerIndex != null ? true : false;
    });
  }

  void segueToGodFinishPage() {
    Navigator.pushReplacementNamed(context, '/finish_god');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/sheep.png'),
          Text('質問文'),
          AnswerSelectButton(
            backgroundColor:
                _selectedAnswerIndex == 0 ? Color(0xffF8DB25) : Colors.white,
            title: '選択肢1',
            onPressed: () => selectAnswer(0),
            borderColor: _selectedAnswerIndex == 0
                ? Color(0xffF8DB25)
                : Color(0xff707070),
            textColor: Color(0xff707070),
          ),
          AnswerSelectButton(
            backgroundColor:
                _selectedAnswerIndex == 1 ? Color(0xffF8DB25) : Colors.white,
            title: '選択肢2',
            onPressed: () => selectAnswer(1),
            borderColor: _selectedAnswerIndex == 1
                ? Color(0xffF8DB25)
                : Color(0xff707070),
            textColor: Color(0xff707070),
          ),
          AnswerDecideButton(
            isSelectAnswer: _isSelectAnswer,
            // TODO: ボタンをdisableにするにはonPressedにnullを渡すが、そうするとモックのスタイルと異なってしまう。
            onPressed: _isSelectAnswer ? () => segueToGodFinishPage() : null,
          )
        ],
      ),
    );
  }
}
