import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';

class MessageList extends ChangeNotifier {
  // 不正に書き換えられることを防止したいので、外部に公開するのはgetterのみ
  List<Answer> get answers => _answers;

  List<Question> get questions => _questions;

  // 内部的に値を管理するリストはprivate

  FirebaseManager _firestoreManager = FirebaseManager();

  List<Answer> _answers = [];
  List<Question> _questions = [];
  


  // 神様モード用の「メッセージ一覧取得」
  Future<void> fetchMessageListForGod() async {
    _answers = await _firestoreManager.fetchAnswerMessagesCollectionAsync();
    notifyListeners();
  }

  // 子羊モード用の「メッセージ一覧取得」
  Future<void> fetchMessageListForSheep() async {
    _questions = await _firestoreManager.fetchQuestionMessagesCollectionAsync();
    notifyListeners();
  }
}
