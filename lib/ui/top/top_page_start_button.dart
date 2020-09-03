import 'package:flutter/material.dart';

class TopPageStartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          SizedBox(
              width: 300,
              height: 50,
              child: RaisedButton(
                  onPressed: () {},
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
                  ))),
        ],
      ),
    );
  }
}
