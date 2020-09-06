import 'package:flutter/material.dart';

class ProfileGodEditInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Container(
      //   margin: EdgeInsets.symmetric(
      //     horizontal: 50.0,
      //     vertical: 10.0,
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         '表示名',
      //         style: TextStyle(
      //           color: const Color(0xFF909090),
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       TextFormField(
      //         obscureText: false,
      //         decoration: const InputDecoration(
      //           hintText: 'マイペースにお腹の空いた神',
      //           filled: true,
      //           fillColor: const Color(0xFFE8E8E8),
      //           border: OutlineInputBorder(
      //             borderRadius: const BorderRadius.all(
      //               const Radius.circular(10.0),
      //             ),
      //             borderSide: BorderSide.none,
      //           ),
      //         ),
      //         onSaved: (String value) => () {
      //           print('Value for field saved as "$value"');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      InfoForm(title: '表示名'),
      InfoForm(title: 'ログインID'),
      InfoForm(title: '神さまの名言'),
    ]);
  }
}

class InfoForm extends StatefulWidget {
  final String title;

  InfoForm({this.title});

  @override
  _InfoFormState createState() => _InfoFormState(title: this.title);
}

class _InfoFormState extends State<InfoForm> {
  final String title;
  String _text = '';

  _InfoFormState({this.title});

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.title,
              style: TextStyle(
                color: const Color(0xFF909090),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
              width: 200,
              child: TextField(
                enabled: true,
                // 入力数
                //maxLength: 10,
                //maxLengthEnforced: false,
                obscureText: false,
                maxLines: 1,
                //パスワード
                onChanged: _handleText,
                decoration: const InputDecoration(
                  hintText: '',
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
