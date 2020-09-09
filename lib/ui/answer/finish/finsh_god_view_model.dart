import 'dart:async';

import 'package:flutter/cupertino.dart';

class Event {}

class FinishGodViewModel extends ChangeNotifier {
  var _matchingSuccessAction = StreamController<Event>();

  StreamController<Event> get matchingSuccessAction => _matchingSuccessAction;

  void returnMainScreen() {
    _matchingSuccessAction.sink.add(Event());
    notifyListeners();
  }

  @override
  void dispose() {
    _matchingSuccessAction.close();
    super.dispose();
  }
}
