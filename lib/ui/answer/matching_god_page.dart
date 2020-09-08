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
      matchingSheep(targetSheepId);
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

  void matchingSheep(String targetSheepId) {
    fireStore
        .collection('matching')
        .doc(targetSheepId)
        .update({'opponent_id': currentUser.uid})
        .then((value) => {
              // TODO: 変更監視して互いにマッチする処理未実装
              successMatching()
            })
        .catchError((error) => {
              // TODO: エラー処理
            });
  }

  Future<void> successMatching() async {
    print("success matching!");
    // TODO: UIのために遅延実行してるが上手いか怪しい
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        status = MatchingStatus.success;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/answer_god');
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
