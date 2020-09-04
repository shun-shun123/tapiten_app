import 'package:flutter/material.dart';

class SelectViewModel extends ChangeNotifier {
  bool _isGod = true;
  bool get isGod => _isGod;

  void selectGodMode() {
    _isGod = true;
    notifyListeners();
  }

  void selectSheepMode() {
    _isGod = false;
    notifyListeners();
  }
}
