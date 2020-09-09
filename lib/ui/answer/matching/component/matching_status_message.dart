import 'package:flutter/material.dart';

enum MatchingStatus {
  searching,
  success,
  failure,
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
        fontSize: 20,
        color: Color(0xff909090),
        fontFamily: 'RictyDiminished-Regular',
      ),
    );
  }
}
