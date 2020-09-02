import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'メッセージ一覧',
        home: Scaffold(
          appBar: AppBar(
            title: MessagePageTitle(),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MessagePageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'メッセージ一覧',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
