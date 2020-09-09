import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_id.dart';

class ProfileEditViewModel extends ChangeNotifier {
  String displayName;
  String loginId;
  String message;

  ProfileEditViewModel() {
    getProfile();
  }

  void setUserName(String name) {
    this.displayName = name;
    notifyListeners();
  }

  void setLoginId(String id) {
    this.loginId = id;
    notifyListeners();
  }

  void setMessage(String message) {
    this.message = message;
    notifyListeners();
  }

  void getProfile() async {
    var userInfo = FirebaseFirestore.instance.collection('user_info');

    userInfo.doc(UserId.userId).get().then((value) {
      displayName = value.get('display_name');
      loginId = value.get('login_id');
      message = value.get('god_message');
    });

    print('get profile');
  }

  void saveProfile() async {
    var userInfo = FirebaseFirestore.instance.collection('user_info');

    userInfo.doc(UserId.userId).set({
      'display_name': displayName,
      'login_id': loginId,
      'god_message': message
    });

    print('save profile');
  }

  //ダミーデータで
  void fetchProfile() {
    displayName = ProfileEditViewModel.dummy().displayName;
    loginId = ProfileEditViewModel.dummy().loginId;
    message = ProfileEditViewModel.dummy().message;
  }

  ProfileEditViewModel.dummy()
      : displayName = 'マイペースな神',
        loginId = '@takoten',
        message = '文字文字文字';
}
