import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/ui/answer/matching/component/matching_status_message.dart';

class Event {}

class MatchingGodViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  User currentUser;
  MatchingStatus status = MatchingStatus.searching;
  StreamSubscription<DocumentSnapshot> _documentSnapshot;
  String opponentId;

  var _matchingSuccessAction = StreamController<Event>();

  StreamController<Event> get matchingSuccessAction => _matchingSuccessAction;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  Future<void> updateSelfStatus() async {
    await fireStore.collection('matching').doc(currentUser.uid).set({
      'is_login': true,
      'is_searching': true,
      'is_waiting': false,
      'opponent_id': null,
    }).then((value) {
      print('update self status: $status');
    }).catchError((error) {
      print('when update status error: $error');
    });
  }

  void searchingSheep() async {
    await updateSelfStatus();
    List waitingSheep = [];

    // TODO: opponent_id == ''もクエリに加える
    await fireStore
        .collection('matching')
        .where('is_login', isEqualTo: true)
        .where('is_waiting', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((element) {
                waitingSheep.add(element.id);
              })
            })
        .catchError((error) => {
              // TODO: エラー処理
            });
    print(waitingSheep);

    // waitingSheepからランダムに選んでマッチング申し込み開始
    if (waitingSheep.length != 0) {
      final randomIndex = Random().nextInt(waitingSheep.length);
      final targetSheepId = waitingSheep[randomIndex];

      // 選択した仔羊のドキュメントが持つopponent_idに自身のidを書き込む
      fireStore
          .collection('matching')
          .doc(targetSheepId)
          .update({'opponent_id': currentUser.uid}).then((value) {
        // 自身のドキュメントのopponent_idを監視して仔羊のものが書き込まれるのを監視
        _documentSnapshot = fireStore
            .collection('matching')
            .doc(currentUser.uid)
            .snapshots()
            .listen((event) {
          var data = event.data();

          if (data['opponent_id'].toString().isNotEmpty &&
              data['opponent_id'] != null) {
            opponentId = data['opponent_id'];
            print(opponentId);
            successMatching(opponentId);
          } else {
            print('dont exist opponent id');
          }
        });
      });
    } else {
      // waitingSheepが空の場合は終了
      Future.delayed(Duration(seconds: 3), () {
        status = MatchingStatus.failure;
        notifyListeners();
      });
    }
  }

  Future<void> successMatching(String opponentId) async {
    print("success matching!");
    await Future.delayed(Duration(seconds: 1), () {
      status = MatchingStatus.success;
      notifyListeners();
    });
    await Future.delayed(Duration(seconds: 2), () {
      _matchingSuccessAction.sink.add(Event());
    });
  }

  @override
  void dispose() {
    _documentSnapshot.cancel();
    _matchingSuccessAction.close();
    super.dispose();
  }
}
