import 'package:flutter/material.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class ProfileGodEditInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    children.add(InfoForm(title: '表示名'));
    children.add(InfoForm(title: 'ログインID'));
    if (UserMode.isGod) {
      children.add(InfoForm(title: '神様の名言'));
    }
    return Column(children: children);
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
