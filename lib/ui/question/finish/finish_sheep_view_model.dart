import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/question.dart';

class FinishSheepViewModel extends ChangeNotifier {
  FinishSheepViewModel(this._question) {
    getResponseFromGod();
  }

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  Question _question = Question(
    answererId: '',
    questionContent: '',
    answer1: '',
    answer2: '',
    godMessage: '',
    selectedAnswerIndex: null,
  );

  Question get question => _question;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  Future<void> getResponseFromGod() async {
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
      print('fetched data');
      print(data);
    });

    question = Question(
      answererId: data['answerer_id'],
      questionContent: data['question_content'],
      answer1: data['answer1'],
      answer2: data['answer2'],
      godMessage: data['god_message'],
      selectedAnswerIndex: data['selected_answer_index'],
    );

    completer.complete(question);
    return completer.future;
  }
}
