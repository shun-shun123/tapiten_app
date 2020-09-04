import 'package:flutter/material.dart';

class TopPageStartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  // NOTE: LoginPage マージ後にコメントイン
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => LoginPage()))
                },
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'はじめる',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
