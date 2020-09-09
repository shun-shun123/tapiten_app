import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/ui/message/model/answer.dart';
import 'package:tapiten_app/ui/message/model/question.dart';

class FirestoreManager {
  // Firebaseの初期化
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      print('Firebase successfully initialized');
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<List<Answer>> fetchAnswerMessagesCollectionAsync() async {
    List<Answer> answers = List<Answer>();
    var completer = Completer<List<Answer>>();

    var query = FirebaseFirestore.instance.collection('messages').doc('answers').collection(UserId.userId);

    // collectionのfetchからAnswerリストの作成
    await query.get().then((querySnapshot) async {
      querySnapshot.docs.forEach((element) {
        answers.add(
          Answer(
            questionerId: element.get('questioner_id'),
            questionContent: element.get('question_content'),
            answer1: element.get('answer1'),
            answer2: element.get('answer2'),
            reviewScore: element.get('review_score'),
            selectedAnswerIndex: element.get('selected_answer_index'),
          ),
        );
      });
    });

    completer.complete(answers);
    return completer.future;
  }

  Future<List<Question>> fetchQuestionMessagesCollectionAsync() async {
    List<Question> questions = List<Question>();
    var completer = Completer<List<Question>>();
    var query = FirebaseFirestore.instance.collection('messages').doc('questions').collection(UserId.userId);

    var res = query.get();
    print(res);
    await res.then((querySnapshot) {
      print(querySnapshot);
      querySnapshot.docs.forEach((element) {
        print('element: $element');
        questions.add(Question(
          answer1: element.get('answer1'),
          answer2: element.get('answer2'),
          questionContent: element.get('question_content'),
          godMessage: element.get('god_message'),
          selectedAnswerIndex: element.get('selected_answer_index'),
          answererId: element.get('answerer_id'),
        ));
      });
    });

    completer.complete(questions);
    return completer.future;
  }
}
