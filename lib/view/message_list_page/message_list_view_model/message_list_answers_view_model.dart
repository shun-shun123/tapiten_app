import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/answer.dart';

// 神さまモードでメッセージ一覧画面に表示するデータを定義したViewModel
class MessageListAnswersViewModel extends ChangeNotifier {
  // 不正に書き換えられることを防止したいので、外部に公開するのはgetterのみ
  List<Answer> get answers => _answers;

  // 通信中などビジー状態を示す
  bool get isBusy => _isBusy;

  FirebaseManager _firestoreManager = FirebaseManager();

  // 内部的に保持している回答リスト
  List<Answer> _answers = [];

  // ビジー状態
  bool _isBusy;

  // 神さま用「メッセージ一覧取得」
  Future<void> fetchMessageAnswersList() async {
    _isBusy = true;
    _answers = await _firestoreManager.fetchAnswerMessagesCollectionAsync();
    _isBusy = false;
    notifyListeners();
  }
}
