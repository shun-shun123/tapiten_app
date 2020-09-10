import 'package:flutter/material.dart';

enum SheepMatchingStatus {
  waiting, // マッチング待機中
  success, // マッチング成功
  complete, // 回答終了
  failure, // 処理失敗
}

class MatchingStatusMessage extends StatelessWidget {
  MatchingStatusMessage({this.status});

  final SheepMatchingStatus status;

  String getStatusMessage(SheepMatchingStatus status) {
    var statusMessage = "";
    if (status == SheepMatchingStatus.waiting) {
      statusMessage = "神さまを探しています";
    } else if (status == SheepMatchingStatus.success) {
      statusMessage = "神さまが対応中です";
    } else if (status == SheepMatchingStatus.complete) {
      statusMessage = "返信が届きました";
    } else if (status == SheepMatchingStatus.failure) {
      statusMessage = "神さまが見つかりませんでした";
    }
    return statusMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getStatusMessage(status),
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'RictyDiminished-Regular',
      ),
    );
  }
}
