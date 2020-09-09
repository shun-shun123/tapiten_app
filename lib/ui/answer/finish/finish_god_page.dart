import 'package:flutter/material.dart';

class FinishGodPage extends StatefulWidget {
  @override
  _FinishGodPageState createState() => _FinishGodPageState();
}

class _FinishGodPageState extends State<FinishGodPage> {
  void returnMainScreen() {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/god.png"),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              '神様お疲れ様でした',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff909090),
                fontFamily: 'RictyDiminished-Regular',
              ),
            ),
            SizedBox(height: 140),
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
              fontSize: 15,
              color: Color(0xff909090),
              fontFamily: 'RictyDiminished-Regular',
            ),
          ),
        ),
      ),
    );
  }
}
