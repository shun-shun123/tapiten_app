import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainGodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: '神メイン',
        home: Scaffold(
            body: Container(
          color: Colors.lightBlue,
          child: Center(
            child: RaisedButton(
              child: Text('back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        )),
      ),
    );
  }
}
