import 'package:flutter/material.dart';

class MatchingGodPage extends StatefulWidget {
  @override
  _MatchingGodPageState createState() => _MatchingGodPageState();
}

class _MatchingGodPageState extends State<MatchingGodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/sheep.png',
            ),
            Text(
              '仔羊を探しています',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            RaisedButton(
              child: Text('back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
