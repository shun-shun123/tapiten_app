import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_god_edit_view_model.dart';

class ProfileEditInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    children.add(ProfileGodEditInfo(title: '表示名'));
    children.add(ProfileGodEditInfo(title: 'ログインID'));
    if (UserMode.isGod) {
      children.add(ProfileGodEditInfo(title: '神さまの名言'));
    }
    return Column(children: children);
  }
}

class ProfileGodEditInfo extends StatefulWidget {
  final String title;

  ProfileGodEditInfo({this.title});

  @override
  _ProfileGodEditInfoState createState() =>
      _ProfileGodEditInfoState(title: this.title);
}

class _ProfileGodEditInfoState extends State<ProfileGodEditInfo> {
  final String title;

  _ProfileGodEditInfoState({this.title});

  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileGodEditViewModel>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '表示名',
                style: TextStyle(
                  color: const Color(0xFF909090),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 200,
                child: TextFormField(
                  initialValue: viewModel.userName,
                  enabled: true,
                  obscureText: false,
                  maxLines: 1,
                  onChanged: (value) {
                    viewModel.setUserName(value);
                  },
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
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ログインID',
                style: TextStyle(
                  color: const Color(0xFF909090),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 200,
                child: TextFormField(
                  initialValue: viewModel.loginId,
                  enabled: true,
                  obscureText: false,
                  maxLines: 1,
                  onChanged: (value) {
                    viewModel.setLoginId(value);
                  },
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
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '神さまの名言',
                style: TextStyle(
                  color: const Color(0xFF909090),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 80.0,
                width: 200,
                child: TextFormField(
                  initialValue: viewModel.message,
                  enabled: true,
                  obscureText: false,
                  maxLines: 2,
                  onChanged: (value) {
                    viewModel.setMessage(value);
                  },
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
          ),
        ),
      ],
    );
  }
}
