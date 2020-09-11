import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';

class Event {}

class FinishGodViewModel extends ChangeNotifier {
  var _returnMainScreenAction = StreamController<Event>();

  StreamController<Event> get returnMainScreenAction => _returnMainScreenAction;

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  void returnMainScreen() {
    // opponent_idを初期化して終了
    fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .update({'opponent_id': ''}).then((value) {
      print('success reset opponent id');
    }).catchError((error) {
      print(error);
    });

    _returnMainScreenAction.sink.add(Event());
    notifyListeners();
  }

  @override
  void dispose() {
    _returnMainScreenAction.close();
    super.dispose();
  }
}
