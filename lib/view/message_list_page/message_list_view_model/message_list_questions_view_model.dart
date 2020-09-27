import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';

// 仔羊モードでメッセージ一覧画面に表示するデータを定義したViewModel
class MessageListQuestionsViewModel extends ChangeNotifier {
  // 不正に書き換えられることを防止したいので、外部に公開するのはgetterのみ
  List<Question> get questions => _questions;

  // 通信中などビジー状態を示す
  bool get isBusy => _isBusy;

  FirebaseManager _firestoreManager = FirebaseManager();

  // 内部的に保持している回答リスト
  List<Question> _questions = [];

  // ビジー状態
  bool _isBusy;

  // 仔羊用「メッセージ一覧取得」
  Future<void> fetchMessageQuestionsList() async {
    _isBusy = true;
    _questions = await _firestoreManager.fetchQuestionMessagesCollectionAsync();
    _isBusy = false;
    notifyListeners();
  }
}
