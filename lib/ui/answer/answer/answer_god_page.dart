import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/answer/answer/component/answer_decide_button.dart';
import 'package:tapiten_app/ui/answer/answer/component/answer_select_button.dart';

class AnswerGodPage extends StatefulWidget {
  @override
  _AnswerGodPageState createState() => _AnswerGodPageState();
}

class _AnswerGodPageState extends State<AnswerGodPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  String questionDocumentIndex;
  String questionContent = "";
  String answer1 = "";
  String answer2 = "";
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

  void onPressAnswerDecideButton() {
    // 該当questionのドキュメントをupdate
    fireStore
        .collection('messages')
        .doc('questions')
        .collection(opponentId)
        .doc(questionDocumentIndex)
        .update({
      // TODO: god_messageをUserコレクションから取得した内容にする
      'god_message': '本当の答えは自分の中にあるのではないか',
      'selected_answer_index': _selectedAnswerIndex,
      'answerer_id': currentUser.uid,
    }).then((value) {
      print('success answer to question!');
    }).catchError((error) {
      print(error);
    });

    Navigator.pushReplacementNamed(context, '/finish_god');
  }

  Future<void> getQuestionFromSheep() async {
    opponentId = ModalRoute.of(context).settings.arguments;
    print(opponentId);

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
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getQuestionFromSheep();
  }

  @override
  Widget build(BuildContext context) {
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
              questionContent,
              style: TextStyle(
                  color: Color(0xff909090),
                  fontFamily: 'RictyDiminished-Regular',
                  fontSize: 15),
            ),
            SizedBox(height: 42),
            AnswerSelectButton(
              backgroundColor:
                  _selectedAnswerIndex == 0 ? Color(0xffF8DB25) : Colors.white,
              title: answer1,
              onPressed: () => selectAnswer(0),
              borderColor: _selectedAnswerIndex == 0
                  ? Color(0xffF8DB25)
                  : Color(0xff909090),
              textColor: Color(0xff909090),
            ),
            AnswerSelectButton(
              backgroundColor:
                  _selectedAnswerIndex == 1 ? Color(0xffF8DB25) : Colors.white,
              title: answer2,
              onPressed: () => selectAnswer(1),
              borderColor: _selectedAnswerIndex == 1
                  ? Color(0xffF8DB25)
                  : Color(0xff909090),
              textColor: Color(0xff909090),
            ),
            AnswerDecideButton(
              isSelectAnswer: _isSelectAnswer,
              // TODO: ボタンをdisableにするにはonPressedにnullを渡すが、そうするとモックのスタイルと異なってしまう。
              onPressed:
                  _isSelectAnswer ? () => onPressAnswerDecideButton() : null,
            )
          ],
        ),
      ),
    );
  }
}
