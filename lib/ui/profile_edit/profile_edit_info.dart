import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

class ProfileEditInfo extends StatefulWidget {
  final String title;

  ProfileEditInfo({this.title});

  @override
  _ProfileEditInfoState createState() =>
      _ProfileEditInfoState(title: this.title);
}

class _ProfileEditInfoState extends State<ProfileEditInfo> {
  final String title;

  _ProfileEditInfoState({this.title});

  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);

    var forms = <Widget>[];
    forms.add(
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
                initialValue: viewModel.displayName,
                enabled: true,
                obscureText: false,
                maxLines: 1,
                onFieldSubmitted: (value) {
                  viewModel.setUserName(value);
                  viewModel.saveProfile();
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
    );
    forms.add(
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
                onFieldSubmitted: (value) {
                  viewModel.setLoginId(value);
                  viewModel.saveProfile();
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
    );

    if (UserMode.isGod) {
      forms.add(
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
                  onFieldSubmitted: (value) {
                    viewModel.setMessage(value);
                    viewModel.saveProfile();
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
      );
    }
    return Column(children: forms);
  }
}
