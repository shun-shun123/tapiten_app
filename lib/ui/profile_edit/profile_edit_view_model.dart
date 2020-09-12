import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class ProfileEditViewModel extends ChangeNotifier {
  String godName;
  String sheepName;
  String displayId;
  String message;

  ProfileEditViewModel() {
    getProfile();
  }

  void setUserName(String name) {
    if (UserMode.isGod) {
      this.godName = name;
    } else {
      this.sheepName = name;
    }
    print('set userName: ${this.godName}');
    notifyListeners();
  }

  void setDisplayId(String id) {
    this.displayId = id;
    notifyListeners();
  }

  void setMessage(String message) {
    this.message = message;
    notifyListeners();
  }

  void getProfile() async {
    var userInfo = FirebaseFirestore.instance.collection('user_info');

    godName = '';
    sheepName = '';
    displayId = '';
    message = '';

    await userInfo.doc(UserId.userId).get().then((value) {
      godName = value.get('god_name');
      sheepName = value.get('sheep_name');
      displayId = value.get('display_id');
      message = value.get('god_message');
    }).then((value) => print('get profile'));

    notifyListeners();
  }

  void saveProfile() async {
    var userInfo = FirebaseFirestore.instance.collection('user_info');

    await userInfo.doc(UserId.userId).set({
      'god_name': godName,
      'sheep_name': sheepName,
      'display_id': displayId,
      'god_message': message
    }).then((value) => print('save profile'));
  }
}
