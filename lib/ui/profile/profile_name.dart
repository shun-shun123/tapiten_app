import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileName extends StatefulWidget {
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  String godName = '';
  String sheepName = '';

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    godName = (viewModel.godName != null) ? viewModel.godName : '';
    sheepName = (viewModel.sheepName != null) ? viewModel.sheepName : '';

    return Container(
      child: Center(
        child: Text(
          (UserMode.isGod) ? godName : sheepName,
          style: kTitleTextStyle.copyWith(
            fontSize: 20,
            color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
          ),
        ),
      ),
    );
  }
}
