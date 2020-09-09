import 'package:flutter/material.dart';

class ProfileGodEditViewModel extends ChangeNotifier {
  String userName;
  String loginId;
  String message;

  ProfileGodEditViewModel() {
    fetchProfile();
  }

  void setUserName(String name) {
    this.userName = name;
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

  void fetchProfile() {
    userName = ProfileGodEditViewModel.dummy().userName;
    loginId = ProfileGodEditViewModel.dummy().loginId;
    message = ProfileGodEditViewModel.dummy().message;
  }

  ProfileGodEditViewModel.dummy()
      : userName = 'マイペースな神',
        loginId = '@takoten',
        message = '文字文字文字';
}
