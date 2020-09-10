import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/profile/sign_out_google.dart';

class ProfileEditInfo extends StatefulWidget {
  final String initGodName;
  final String initSheepName;
  final String initDisplayId;
  final String initMessage;

  ProfileEditInfo({
    this.initGodName,
    this.initSheepName,
    this.initDisplayId,
    this.initMessage,
  });

  @override
  _ProfileEditInfoState createState() => _ProfileEditInfoState(
      initGodName: this.initGodName,
      initSheepName: this.initSheepName,
      initDisplayId: this.initDisplayId,
      initMessage: this.initMessage);
}

class _ProfileEditInfoState extends State<ProfileEditInfo> {
  final String initGodName;
  final String initSheepName;
  final String initDisplayId;
  final String initMessage;

  _ProfileEditInfoState({
    this.initGodName,
    this.initSheepName,
    this.initDisplayId,
    this.initMessage,
  });

  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    var forms = <Widget>[];

    print('initGodName = $initGodName');
    print('godName = ${viewModel.godName}');

    forms.add(
      InfoForm(
        title: '表示名',
        height: 40,
        initialValue: UserMode.isGod ? this.initGodName : this.initSheepName,
        onSubmit: (value) {
          viewModel.setUserName(value);
        },
      ),
    );
    forms.add(
      InfoForm(
        title: 'ログインID',
        height: 40,
        initialValue: this.initDisplayId,
        onSubmit: (value) {
          viewModel.setDisplayId(value);
        },
      ),
    );
    if (UserMode.isGod) {
      forms.add(
        InfoForm(
          title: '神さまの名言',
          height: 80.0,
          initialValue: this.initMessage,
          onSubmit: (value) {
            viewModel.setMessage(value);
          },
        ),
      );
    }
    if (UserMode.isGod) {
      forms.add(SignOutGoogle(
        color: Color(0xFF909090),
      ));
    }else{
      forms.add(SignOutGoogle(
        color: Colors.white,
      ));
    }
    return Column(children: forms);
  }
}

class InfoForm extends StatefulWidget {
  final String title;
  final double height;
  final String initialValue;
  final Function(String) onSubmit;
  final TextEditingController controller;

  InfoForm(
      {this.title,
      this.height,
      this.initialValue,
      this.onSubmit,
      this.controller});

  @override
  _InfoFormState createState() => _InfoFormState(
        title: this.title,
        height: this.height,
        initialValue: this.initialValue,
        onSubmit: (value) => this.onSubmit(value),
        controller: this.controller,
      );
}

class _InfoFormState extends State<InfoForm> {
  final String title;
  final double height;
  final String initialValue;
  final Function(String) onSubmit;
  final TextEditingController controller;

  _InfoFormState(
      {this.title,
      this.height,
      this.initialValue,
      this.onSubmit,
      this.controller});

  @override
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
            height: this.height,
            width: 200,
            child: TextFormField(
              initialValue: this.initialValue,
              enabled: true,
              obscureText: false,
              maxLines: 1,
              onFieldSubmitted: (value) => this.onSubmit(value),
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
    );
  }
}
