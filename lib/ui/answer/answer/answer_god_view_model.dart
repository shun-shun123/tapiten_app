import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/question.dart';

class Event {}

class AnswerGodViewModel extends ChangeNotifier {
  AnswerGodViewModel(this._opponentId, this._question) {
    getQuestionFromSheep();
  }

  var _answerSuccessAction = StreamController<Event>();

  StreamController<Event> get answerSuccessAction => _answerSuccessAction;

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  String questionDocumentIndex;

  Question _question = Question(
    answererId: '',
    questionContent: '',
    answer1: '',
    answer2: '',
    godMessage: '',
    selectedAnswerIndex: null,
  );

  int _selectedAnswerIndex;
  bool _isSelectAnswer = false;
  String _opponentId;

  Question get question => _question;

  int get selectedAnswerIndex => _selectedAnswerIndex;

  bool get isSelectAnswer => _isSelectAnswer;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  void selectAnswer(int index) {
    _selectedAnswerIndex = _selectedAnswerIndex != index ? index : null;
    _isSelectAnswer = _selectedAnswerIndex != null ? true : false;
    notifyListeners();
  }

  void onPressAnswerDecideButton() {
    // 該当questionのドキュメントをupdate
    fireStore
        .collection('messages')
        .doc('questions')
        .collection(_opponentId)
        .doc(questionDocumentIndex)
        .update({
      // TODO: god_messageをUserコレクションから取得した内容にする
      'god_message': '本当の答えは自分の中にあるのではないか',
      'selected_answer_index': selectedAnswerIndex,
      'answerer_id': currentUser.uid,
    }).then((value) {
      print('success answer to question!');
    }).catchError((error) {
      print(error);
    });

    _answerSuccessAction.sink.add(Event());
  }

  void getQuestionFromSheep() async {
    getCurrentUser();
    _question = await fetchQuestionDocumentAsync();
    notifyListeners();
  }

  Future<Question> fetchQuestionDocumentAsync() async {
    Question question = Question(
      answererId: '',
      questionContent: '',
      answer1: '',
      answer2: '',
      godMessage: '',
      selectedAnswerIndex: null,
    );
    var completer = Completer<Question>();
    Map<String, dynamic> data;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(_opponentId)
        .get()
        .then((value) {
      questionDocumentIndex = (value.docs.length - 1).toString();
    });

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(_opponentId)
        .doc(questionDocumentIndex)
        .get()
        .then((value) {
      data = value.data();
      print('fetched data');
      print(data);
    });

    question = Question(
      answererId: null,
      questionContent: data['question_content'],
      answer1: data['answer1'],
      answer2: data['answer2'],
      godMessage: null,
      selectedAnswerIndex: null,
    );
    print('_question.questionContent: ${_question.questionContent}');

    completer.complete(question);
    return completer.future;
  }

  @override
  void dispose() {
    _answerSuccessAction.close();
    super.dispose();
  }
}
