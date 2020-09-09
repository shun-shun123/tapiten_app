import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class SelectViewModel extends ChangeNotifier {
  bool _isGod = true;
  bool get isGod => _isGod;

  void selectGodMode() {
    print('isGod is changed to true');
    UserMode.isGod = true;
    notifyListeners();
  }

  void selectSheepMode() {
    print('isGod is changed to false');
    UserMode.isGod = false;
    notifyListeners();
  }
}
