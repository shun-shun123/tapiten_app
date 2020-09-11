import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';

class MessageList extends ChangeNotifier {
  // 不正に書き換えられることを防止したいので、外部に公開するのはgetterのみ
  List<Answer> get answers => _answers;

  List<Question> get questions => _questions;

  bool get isBusy => _isBusy;

  // 内部的に値を管理するリストはprivate

  FirebaseManager _firestoreManager = FirebaseManager();

  List<Answer> _answers = [];
  List<Question> _questions = [];
  bool _isBusy;

  // 神様モード用の「メッセージ一覧取得」
  Future<void> fetchMessageListForGod() async {
    _isBusy = true;
    _answers = await _firestoreManager.fetchAnswerMessagesCollectionAsync();
    _isBusy = false;
    notifyListeners();
  }

  // 子羊モード用の「メッセージ一覧取得」
  Future<void> fetchMessageListForSheep() async {
    _isBusy = true;
    _questions = await _firestoreManager.fetchQuestionMessagesCollectionAsync();
    _isBusy = false;
    notifyListeners();
  }
}
