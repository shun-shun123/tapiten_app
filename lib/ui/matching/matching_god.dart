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

    if (waitingSheep.length != 0) {
      final randomIndex = Random().nextInt(waitingSheep.length);
      final targetSheepId = waitingSheep[randomIndex];
      matchingSheep(targetSheepId);
    } else {
      status = MatchingStatus.failure;
    }
  }

  void matchingSheep(String targetSheepId) {
    fireStore
        .collection('matching')
        .doc(targetSheepId)
        .update({'opponent_id': currentUser.uid})
        .then((value) => {status = MatchingStatus.success})
        .catchError((error) => {
              // TODO: エラー処理
            });
  }

  void successMatching() {
    print("success matching!");
    setState(() {
      status = MatchingStatus.success;
    });
  }

  Future getWaitingSheep() async {
    List waitingSheep;

    return waitingSheep;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    searchingSheep();
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
              'images/sheep.png',
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
