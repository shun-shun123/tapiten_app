import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MatchingStatus {
  searching,
  success,
  failure,
}

class MatchingGodPage extends StatefulWidget {
  @override
  _MatchingGodPageState createState() => _MatchingGodPageState();
}

class _MatchingGodPageState extends State<MatchingGodPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;
  MatchingStatus status = MatchingStatus.searching;
  StreamSubscription<DocumentSnapshot> _documentSnapshot;

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        currentUser = user;
      }
    } catch (e) {
      print(e);
    }
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

          String opponentId;
          if (data['opponent_id'] != "") {
            opponentId = data['opponent_id'];
            print(opponentId);
            successMatching(opponentId);
          }
        });
      });
    } else {
      // waitingSheepが空の場合は終了
      setState(() {
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            status = MatchingStatus.failure;
          });
        });
      });
    }
  }

  Future<void> successMatching(String opponentId) async {
    print("success matching!");
    // TODO: UIのために遅延実行してるが上手いか怪しい
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        status = MatchingStatus.success;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      print('argument: opponentId= $opponentId');
      Navigator.pushReplacementNamed(
        context,
        '/answer_god',
        arguments: opponentId,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    searchingSheep();
  }

  @override
  void dispose() {
    status = MatchingStatus.searching;
    _documentSnapshot.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/sheep_circle.png',
            ),
            MatchingStatusMessage(
              status: status,
            ),
            RaisedButton(
              child: Text('back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MatchingStatusMessage extends StatelessWidget {
  MatchingStatusMessage({this.status});

  final MatchingStatus status;

  String getStatusMessage(MatchingStatus status) {
    var statusMessage = "";
    if (status == MatchingStatus.searching) {
      statusMessage = "仔羊を探しています";
    } else if (status == MatchingStatus.success) {
      statusMessage = "仔羊が見つかりました";
    } else if (status == MatchingStatus.failure) {
      statusMessage = "仔羊が見つかりませんでした";
    }
    return statusMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getStatusMessage(status),
      style: TextStyle(
        fontSize: 18,
        color: Colors.black54,
      ),
    );
  }
}
