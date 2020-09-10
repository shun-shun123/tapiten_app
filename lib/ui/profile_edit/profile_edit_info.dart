import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/profile/sign_out_google.dart';

class ProfileEditInfo extends StatefulWidget {
  @override
  _ProfileEditInfoState createState() => _ProfileEditInfoState();
}

class _ProfileEditInfoState extends State<ProfileEditInfo> {
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    var forms = <Widget>[];

    print(viewModel.godName);

    forms.add(
      InfoForm(
        title: '表示名',
        height: 40,
        initialValue: UserMode.isGod ? viewModel.godName : viewModel.sheepName,
        onSubmit: (value) {
          viewModel.setUserName(value);
          viewModel.saveProfile();
        },
      ),
    );
    forms.add(
      InfoForm(
        title: 'ログインID',
        height: 40,
        initialValue: viewModel.displayId,
        onSubmit: (value) {
          viewModel.setDisplayId(value);
          viewModel.saveProfile();
        },
      ),
    );
    if (UserMode.isGod) {
      forms.add(
        InfoForm(
          title: '神さまの名言',
          height: 80.0,
          initialValue: viewModel.message,
          onSubmit: (value) {
            viewModel.setMessage(value);
            viewModel.saveProfile();
          },
        ),
      );
    }
<<<<<<< HEAD

    return Column(children: forms);
=======
    if (UserMode.isGod) {
      children.add(SignOutGoogle(
        color: Color(0xFF909090),
      ));
    }else{
      children.add(SignOutGoogle(
        color: Colors.white,
      ));
    }
    return Column(children: children);
>>>>>>> e9d2f36... ボタンの色をモードで分岐させ、プロフ編集画面に配置
  }
}

class InfoForm extends StatefulWidget {
  final String title;
  final double height;
  final String initialValue;
  final Function(String) onSubmit;

  InfoForm({this.title, this.height, this.initialValue, this.onSubmit});

  @override
  _InfoFormState createState() => _InfoFormState(
        title: this.title,
        height: this.height,
        initialValue: this.initialValue,
        onSubmit: (value) => this.onSubmit(value),
      );
}

class _InfoFormState extends State<InfoForm> {
  final String title;
  final double height;
  final String initialValue;
  final Function(String) onSubmit;

  _InfoFormState({this.title, this.height, this.initialValue, this.onSubmit});

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
