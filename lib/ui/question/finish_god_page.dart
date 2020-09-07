import 'package:flutter/material.dart';

class FinishGodPage extends StatefulWidget {
  @override
  _FinishGodPageState createState() => _FinishGodPageState();
}

class _FinishGodPageState extends State<FinishGodPage> {
  void returnMainScreen() {
    // Navigator.of(context).removeRoute(ModalRoute.withName('/matching_god'));
    // Navigator.of(context).removeRoute(ModalRoute.withName('/answer_god'));
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('終了画面'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/god.png'),
            Text(
              '神様お疲れ様でした',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            ReturnMainScreenButton(onPressed: () => returnMainScreen())
          ],
        ),
      ),
    );
  }
}

class ReturnMainScreenButton extends StatelessWidget {
  ReturnMainScreenButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: ButtonTheme(
          minWidth: 174,
          height: 38,
          child: RaisedButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Color(0xffF8D825),
              ),
            ),
            color: Color(0xffF8D825),
            child: Text(
              '戻る',
              style: TextStyle(
                color: Color(0xff707070),
              ),
            ),
          ),
        ));
  }
}
