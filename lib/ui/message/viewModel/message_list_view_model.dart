import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_cell_view_model.dart';

class MessageList extends ChangeNotifier {
  final List<Answer> answers;
  MessageList({this.answers}) {
    fetchMessageList();
  }

  void fetchMessageList() async {
    // Firebaseと通信する予定なので、非同期で擬似遅延を実装してる
    print('fetchMessageList start...');
    await new Future.delayed(new Duration(seconds: 1));
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    answers.add(Answer.dummy());
    print('fetchMessageList finished...');
    notifyListeners();
    print('Notify messageList');
  }
}
