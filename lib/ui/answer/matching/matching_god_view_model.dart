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
  FirebaseManager _firebaseManager = FirebaseManager();

  User currentUser;
  MatchingStatus status = MatchingStatus.searching;
  StreamSubscription<DocumentSnapshot> _documentSnapshot;
  String opponentId;

  var _loginSuccessAction = StreamController<Event>();

  StreamController<Event> get loginSuccessAction => _loginSuccessAction;

  void getCurrentUser() {
    currentUser = _firebaseManager.getCurrentUser();
    print(currentUser);
  }

  void searchingSheep() async {
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
          if (data == null) {
            print('data is empty!');
            return;
          }

          if (data['opponent_id'] != "") {
            opponentId = data['opponent_id'];
            print(opponentId);
            successMatching(opponentId);
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
    await Future.delayed(Duration(seconds: 3), () {
      status = MatchingStatus.success;
      _loginSuccessAction.sink.add(Event());
      print('argument: opponentId= $opponentId');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _documentSnapshot.cancel();
    _loginSuccessAction.close();
    super.dispose();
  }
}
