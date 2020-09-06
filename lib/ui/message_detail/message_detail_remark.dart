import 'package:flutter/material.dart';

class MessageDetailRemark extends StatelessWidget {
  final String remark;
  MessageDetailRemark({this.remark});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text('今回の神様からの名言'),
          SizedBox(
            width: 200,
            height: 100,
            child: Container(
              color: Color(0xFF909090),
              child: Text(
                remark,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
