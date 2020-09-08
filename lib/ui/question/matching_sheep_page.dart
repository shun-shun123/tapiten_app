import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MatchingStatus {
  waiting,
  success,
  failure,
}

class MatchingSheepPage extends StatefulWidget {
  @override
  _MatchingSheepPageState createState() => _MatchingSheepPageState();
}

class _MatchingSheepPageState extends State<MatchingSheepPage> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;
  MatchingStatus status = MatchingStatus.waiting;
  StreamSubscription<DocumentSnapshot> snapshot;

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        currentUser = user;
        print('current user: ${currentUser.displayName}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> makeCurrentUserDoc() async {
    await fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .get()
        .then((value) async => {
              if (value.data() == null)
                {
                  await fireStore
                      .collection('matching')
                      .doc(currentUser.uid)
                      .set({
                    // TODO: Modelに閉じ込めるべき
                    'is_login': true,
                    'is_searching': false,
                    'is_waiting': true,
                    'opponent_id': "",
                  }).then((value) => print('now generate current user doc!'))
                },
              print('in make current User Doc: ${value.data()}')
            })
        .catchError(
          (error) => {print(error)},
        );
  }

  Future<void> updateSelfStatus() async {
    await fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .update({'is_waiting': true})
        .then((value) => print('update self status: $status'))
        .catchError((error) => {print('in update status error: $error')});
  }

  Future<void> matchingWithGod() async {
    await makeCurrentUserDoc();
    await updateSelfStatus();

    snapshot = fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .snapshots()
        .listen((event) {
      final data = event.data();
      if (data == null) {
        print('data is empty!');
        return;
      }

      String opponentId;
      if (data['opponent_id'] != null) {
        opponentId = data['opponent_id'];

        fireStore
            .collection('matching')
            .doc(opponentId)
            .update({'opponent_id': currentUser.uid});
      }
      print('current opponent_id: $opponentId');
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    matchingWithGod();
  }

  @override
  void dispose() {
    status = MatchingStatus.waiting;
    super.dispose();
    snapshot.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff909090),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/god.png"),
                ),
              ),
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
    if (status == MatchingStatus.waiting) {
      statusMessage = "神さまを探しています";
    } else if (status == MatchingStatus.success) {
      statusMessage = "神さまが見つかりました";
    } else if (status == MatchingStatus.failure) {
      statusMessage = "神さまが見つかりませんでした";
    }
    return statusMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getStatusMessage(status),
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
