import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/profile/sign_out_google.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

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

  ProfileEditViewModel viewModel;

  _ProfileEditInfoState({
    this.initGodName,
    this.initSheepName,
    this.initDisplayId,
    this.initMessage,
  });

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ProfileEditViewModel>(context, listen: false);
    viewModel.getProfile();
  }

  Widget build(BuildContext context) {
    var forms = <Widget>[];

    //print('initGodName = $initGodName');
    print('godName = ${viewModel.godName}');

    forms.add(
      InfoForm(
        title: '表示名',
        maxLines: 1,
        maxLength: 20,
        initialValue: UserMode.isGod ? this.initGodName : this.initSheepName,
        onChanged: (value) {
          viewModel.setUserName(value);
        },
      ),
    );
    forms.add(
      InfoForm(
        title: 'ログインID',
        maxLines: 1,
        maxLength: 20,
        initialValue: this.initDisplayId,
        onChanged: (value) {
          viewModel.setDisplayId(value);
        },
      ),
    );
    if (UserMode.isGod) {
      forms.add(
        InfoForm(
          title: '神さまの名言',
          maxLines: 3,
          maxLength: 40,
          initialValue: this.initMessage,
          onChanged: (value) {
            viewModel.setMessage(value);
          },
        ),
      );
    }
    if (UserMode.isGod) {
      forms.add(SignOutGoogle(
        color: Color(0xFF909090),
      ));
    } else {
      forms.add(SignOutGoogle(
        color: Colors.white,
      ));
    }
    return Column(children: forms);
  }
}

class InfoForm extends StatefulWidget {
  final String title;
  final int maxLines;
  final int maxLength;
  final String initialValue;
  final Function(String) onChanged;

  InfoForm({
    this.title,
    this.maxLines,
    this.maxLength,
    this.initialValue,
    this.onChanged,
  });

  @override
  _InfoFormState createState() => _InfoFormState(
        title: this.title,
        maxLines: this.maxLines,
        maxLength: this.maxLength,
        initialValue: this.initialValue,
        onChanged: (value) => this.onChanged(value),
      );
}

class _InfoFormState extends State<InfoForm> {
  final String title;
  final int maxLines;
  final int maxLength;
  final String initialValue;
  final Function(String) onChanged;

  _InfoFormState({
    this.title,
    this.maxLines,
    this.maxLength,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 45.0,
        vertical: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: kTitleTextStyle.copyWith(
              color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: kTextFormFieldTextStyle,
            initialValue: this.initialValue,
            enabled: true,
            obscureText: false,
            maxLines: this.maxLines,
            maxLength: this.maxLength,
            onChanged: (value) => {
              this.onChanged(value),
              print('onChanged'),
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
        ],
      ),
    );
  }
}
