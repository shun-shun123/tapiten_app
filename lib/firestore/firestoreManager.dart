import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';

class FirebaseManager {
  // Firebaseの初期化
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      print('Firebase successfully initialized');
    } on Exception catch (error) {
      print(error);
    }
  }

  // Current Userの取得
  static User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<List<Answer>> fetchAnswerMessagesCollectionAsync() async {
    List<Answer> answers = List<Answer>();
    var completer = Completer<List<Answer>>();

    var query = FirebaseFirestore.instance.collection('messages');

    // collectionのfetchからAnswerリストの作成
    await query.get().then((querySnapshot) async {
      querySnapshot.docs.forEach((element) {
        // answersの中身を全部イテレーションする
        element.get('answers').forEach((userEntries) {
          // userIdでイテレーションする
          userEntries.forEach((String userId, dynamic answer) {
            answers.add(Answer(
              questionerId: answer['questioner_id'],
              questionContent: answer['question_content'],
              answer1: answer['answer1'],
              answer2: answer['answer2'],
              reviewScore: answer['review_score'],
              selectedAnswerIndex: answer['selected_answer_index'],
            ));
          });
        });
      });
    });

    completer.complete(answers);
    return completer.future;
  }

  Future<List<Question>> fetchQuestionMessagesCollectionAsync() async {
    List<Question> questions = List<Question>();
    var completer = Completer<List<Question>>();
    var query = FirebaseFirestore.instance.collection('messages');

    // collectionのfetchからQuestionリストの作成
    await query.get().then((querySnapshot) async {
      querySnapshot.docs.forEach((element) {
        // questionsの中身を全部イテレーションする
        element.get('questions').forEach((userEntries) {
          // userIdでイテレーションする
          userEntries.forEach((String userId, dynamic question) {
            questions.add(Question(
              answererId: question['answerer_id'],
              questionContent: question['question_content'],
              answer1: question['answer1'],
              answer2: question['answer2'],
              godMessage: question['god_message'],
              selectedAnswerIndex: question['selected_answer_index'],
            ));
          });
        });
      });
    });

    completer.complete(questions);
    return completer.future;
  }
}
