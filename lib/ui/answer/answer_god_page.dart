import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/answer/component/answer_decide_button.dart';
import 'package:tapiten_app/ui/answer/component/answer_select_button.dart';

class AnswerGodPage extends StatefulWidget {
  @override
  _AnswerGodPageState createState() => _AnswerGodPageState();
}

class _AnswerGodPageState extends State<AnswerGodPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  String questionContent = "";
  String answer1 = "";
  String answer2 = "";
  int selectedAnswerIndex;
  String godMessage = "";
  Map<String, dynamic> data;

  int _selectedAnswerIndex;
  bool _isSelectAnswer = false;
  String opponentId;

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        currentUser = user;
        print('current user: ${currentUser.displayName}');
      }
    } catch (e) {
      print(e);
    }
  }

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

  Future<void> getQuestionFromSheep() async {
    opponentId = ModalRoute.of(context).settings.arguments;
    print(opponentId);

    String questionDocumentIndex;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(opponentId)
        .get()
        .then((value) {
      questionDocumentIndex = (value.docs.length - 1).toString();
    });

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(opponentId)
        .doc(questionDocumentIndex)
        .get()
        .then((value) {
      data = value.data();
      print(data);
    });

    setState(() {
      questionContent = data['question_content'];
      answer1 = data['answer1'];
      answer2 = data['answer2'];
      selectedAnswerIndex = data['selected_answer_index'];
      godMessage = data['god_message'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getQuestionFromSheep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/sheep_circle.png'),
          Text(questionContent),
          AnswerSelectButton(
            backgroundColor:
                _selectedAnswerIndex == 0 ? Color(0xffF8DB25) : Colors.white,
            title: answer1,
            onPressed: () => selectAnswer(0),
            borderColor: _selectedAnswerIndex == 0
                ? Color(0xffF8DB25)
                : Color(0xff707070),
            textColor: Color(0xff707070),
          ),
          AnswerSelectButton(
            backgroundColor:
            _selectedAnswerIndex == 1 ? Color(0xffF8DB25) : Colors.white,
            title: answer2,
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
