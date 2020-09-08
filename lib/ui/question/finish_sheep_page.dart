import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class FinishSheepPage extends StatefulWidget {
  @override
  _FinishSheepPageState createState() => _FinishSheepPageState();
}

class _FinishSheepPageState extends State<FinishSheepPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  String questionContent = "";
  String answer1 = "";
  String answer2 = "";
  int selectedAnswerIndex;
  String godMessage = "";
  Map<String, dynamic> data;

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

  void returnMainScreen() {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  Future<void> getResponseFromGod() async {
    String questionDocumentIndex;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .get()
        .then((value) {
      questionDocumentIndex = (value.docs.length - 1).toString();
    });

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
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
    getCurrentUser();
    getResponseFromGod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              questionContent,
              style: kTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28),
            ChoiceText(isSelect: selectedAnswerIndex == 0, text: answer1),
            SizedBox(height: 18),
            ChoiceText(isSelect: selectedAnswerIndex == 1, text: answer2),
            SizedBox(height: 60),
            Text(
              '今回の神さまからの名言',
              style: kTitleTextStyle,
            ),
            GodMessage(messageText: godMessage),
            SizedBox(height: 42),
            ReturnMainScreenButton(onPressed: () => returnMainScreen())
          ],
        ),
      ),
    );
  }
}

class ChoiceText extends StatelessWidget {
  ChoiceText({@required this.isSelect, @required this.text});

  final bool isSelect;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: isSelect ? Color(0xff9FD53E) : Color(0xff707070),
        ),
      ),
      color: isSelect ? Color(0xff9FD53E) : Colors.white,
      child: Container(
        width: isSelect ? 164 : 148,
        height: isSelect ? 40 : 32,
        child: Center(
          child: Padding(
            padding: isSelect
                ? EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  )
                : EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelect ? Colors.white : Color(0xff707070),
                fontSize: isSelect ? 14 : 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GodMessage extends StatelessWidget {
  final String messageText;

  GodMessage({@required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            color: Color(0xff707070),
          ),
        ),
        color: Colors.white,
        child: Container(
          width: 212,
          height: 90,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                messageText,
                style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReturnMainScreenButton extends StatelessWidget {
  ReturnMainScreenButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ButtonTheme(
          minWidth: 174,
          height: 38,
          child: RaisedButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Color(0xff9FD53E),
              ),
            ),
            color: Color(0xff9FD53E),
            child: Text(
              '戻る',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
