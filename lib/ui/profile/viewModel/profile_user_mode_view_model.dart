import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class ProfileUserMode extends ChangeNotifier {
  ProfileUserMode() {
    getProfile();
    calculateGodRank();
  }

  String godName;
  String sheepName;
  String displayId;
  String message;

  bool get userMode => UserMode.isGod;
  double godScore = 0;

  bool isBusy = true;

  void getProfile() async {
    var userInfo = FirebaseFirestore.instance.collection('user_info');

    await userInfo.doc(UserId.userId).get().then((value) {
      godName = value.get('god_name');
      sheepName = value.get('sheep_name');
      displayId = value.get('display_id');
      message = value.get('god_message');
    }).then((value) {
      print('get profile');
      notifyListeners();
    });

    print(godName);
    print(sheepName);
    print(displayId);
  }

  void changeUserMode(bool isGod) {
    print('changeUserMode');
    var userMode = UserMode();
    userMode.saveUserMode(isGod: isGod);
    notifyListeners();
  }

  Future<void> calculateGodRank() async {
    isBusy = true;
    final firestore = FirebaseFirestore.instance;
    double totalScore = 0.0;
    int answerTimes = 0;

    await firestore
        .collection('messages')
        .doc('answers')
        .collection(UserId.userId)
        .get()
        .then((value) {
      final docs = value.docs;
      answerTimes = docs.length;
      docs.forEach((element) {
        totalScore += element.get('review_score');
      });
    }).catchError((error) {
      print(error);
    });

    var _godScore = totalScore / answerTimes;
    if (answerTimes == 0) {
      _godScore = 0;
    }

    print(_godScore);
    godScore = _godScore;
    isBusy = false;
  }
}
