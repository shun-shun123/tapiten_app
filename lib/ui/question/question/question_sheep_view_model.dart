import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';

class Event {}

class QuestionSheepViewModel extends ChangeNotifier {
  final form = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  String questionText;
  String firstChoiceText;
  String secondChoiceText;
  bool isFillForm = false;
  User currentUser;

  var _questionSuccessAction = StreamController<Event>();

  StreamController<Event> get questionSuccessAction => _questionSuccessAction;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  void checkFillForm() {
    form.currentState.save();
    isFillForm = questionText.isNotEmpty &&
            firstChoiceText.isNotEmpty &&
            secondChoiceText.isNotEmpty
        ? true
        : false;
    notifyListeners();
  }

  void onPressDecideButton() async {
    form.currentState.save();
    print(questionText);
    print(firstChoiceText);
    print(secondChoiceText);

    _questionSuccessAction.sink.add(Event());
    notifyListeners();

    String newDocumentIndex;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .get()
        .then((value) {
      newDocumentIndex = value.docs.length.toString();
      print('newDocumentIndex: $newDocumentIndex');
    }).catchError((error) => {print(error)});

    fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .doc(newDocumentIndex)
        .set({
      'answerer_id': null,
      'answerer_name': null,
      'question_content': questionText,
      'answer1': firstChoiceText,
      'answer2': secondChoiceText,
      'god_message': null,
      'selected_answer_index': null,
    }).then((value) {
      print('success update my questions');
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    _questionSuccessAction.close();
    super.dispose();
  }
}
