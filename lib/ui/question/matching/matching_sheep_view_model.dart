import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';

import 'component/matching_status_message.dart';

class Event {}

class MatchingSheepViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;
  SheepMatchingStatus status = SheepMatchingStatus.waiting;
  StreamSubscription<DocumentSnapshot> _documentSnapshot;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  Future<void> updateSelfStatus() async {
    await fireStore.collection('matching').doc(currentUser.uid).set({
      'is_login': true,
      'is_searching': false,
      'is_waiting': true,
      'opponent_id': null,
    }).then((value) {
      print('update self status: $status');
    }).catchError((error) {
      print('when update status error: $error');
    });
  }

  Future<void> matchingWithGod() async {
    await updateSelfStatus();

    _documentSnapshot = fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .snapshots()
        .listen((event) {
      var data = event.data();
      if (data == null) {
        print('data is empty!');
        return;
      }

      String opponentId;
      if (data['opponent_id'] != "") {
        opponentId = data['opponent_id'];

        fireStore
            .collection('matching')
            .doc(opponentId)
            .update({'opponent_id': currentUser.uid})
            .then((value) => {
                  print('success write my id to opponent user!'),
                  successMatching()
                })
            .catchError((error) => {print(error)});
      }
      print('current opponent_id: $opponentId');
    });
  }

  Future<void> successMatching() async {
    await Future.delayed(Duration(seconds: 1), () {
      status = SheepMatchingStatus.success;
      notifyListeners();
      waitingResponseFromGod();
    });
  }

  Future<void> waitingResponseFromGod() async {
    String questionDocumentIndex;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .get()
        .then((value) {
      questionDocumentIndex = (value.docs.length - 1).toString();
    });

    _documentSnapshot = await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .doc(questionDocumentIndex)
        .snapshots()
        .listen((event) {
      bool isFillField = true;
      var data = event.data();
      print('------------');
      data.forEach((key, value) {
        print('$key,$value');
        if (value == null) {
          isFillField = false;
        }
      });
      print(isFillField);
      print('------------');

      if (isFillField) {
        completeResponse();
      }
    });
  }

  void completeResponse() {
    print('completeResponse');
    status = SheepMatchingStatus.complete;
    notifyListeners();
  }

  @override
  void dispose() {
    _documentSnapshot.cancel();
    super.dispose();
  }
}
