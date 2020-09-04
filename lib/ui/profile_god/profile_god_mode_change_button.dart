import 'package:flutter/material.dart';

class ProfileGodModeChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 175,
          child: RaisedButton(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '仔羊モード',
                    style: TextStyle(
                      color: Color(0xFF909090),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.circle,
                  color: Colors.black,
                ),
              ],
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
