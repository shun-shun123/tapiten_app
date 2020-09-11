import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/answer.dart';
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

  Future<void> onPressAnswerDecideButton() async {
    await fireStore
        .collection('user_info')
        .doc(currentUser.uid)
        .get()
        .then((value) {
      final data = value.data();
      _question.godMessage = data['god_message'];
    }).catchError((error) {
      print(error);
    });

    // インスタンスの内容更新
    _question.selectedAnswerIndex = _selectedAnswerIndex;
    _question.answererId = currentUser.uid;

    // 該当questionのドキュメントをupdate
    fireStore
        .collection('messages')
        .doc('questions')
        .collection(_opponentId)
        .doc(questionDocumentIndex)
        .update({
      'god_message': _question.godMessage,
      'selected_answer_index': _question.selectedAnswerIndex,
      'answerer_id': _question.answererId,
    }).then((value) {
      print('success answer to question!');
    }).catchError((error) {
      print(error);
    });

    // 自身のanswersに回答結果をadd
    String newDocumentIndex;
    await fireStore
        .collection('messages')
        .doc('answers')
        .collection(currentUser.uid)
        .get()
        .then((value) {
      newDocumentIndex = value.docs.length.toString();
      print('newDocumentIndex: $newDocumentIndex');
    }).catchError((error) => {print(error)});

    final answer = Answer(
      questionerId: _opponentId,
      questionContent: _question.questionContent,
      answer1: _question.answer1,
      answer2: _question.answer2,
      reviewScore: 3,
      //TODO: レビュー機能が入ったら見直し
      selectedAnswerIndex: _question.selectedAnswerIndex,
    );

    fireStore
        .collection('messages')
        .doc('answers')
        .collection(currentUser.uid)
        .doc(newDocumentIndex)
        .set({
      'questioner_id': answer.questionerId,
      'question_content': answer.questionContent,
      'answer1': answer.answer1,
      'answer2': answer.answer2,
      'review_score': answer.reviewScore,
      'selected_answer_index': answer.selectedAnswerIndex,
    }).then((value) {
      print('success update my answers');
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
