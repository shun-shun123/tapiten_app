import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class ProfileUserMode extends ChangeNotifier {
  bool get userMode => UserMode.isGod;

  void changeUserMode(bool isGod) {
    print('changeUserMode');
    var userMode = UserMode();
    userMode.saveUserMode(isGod: isGod);
    notifyListeners();
  }
}
