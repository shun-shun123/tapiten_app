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
            width: 250,
            height: 100,
            child: Card(
              color: Color(0xFF909090),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: Text(
                  remark,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
