import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileId extends StatefulWidget {
  @override
  _ProfileIdState createState() => _ProfileIdState();
}

class _ProfileIdState extends State<ProfileId> {
  String displayId = '';

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    displayId = (viewModel.displayId != null) ? viewModel.displayId : '';

    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Text(
          displayId,
          style: kTitleTextStyle.copyWith(
            fontSize: 20,
            color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
          ),
        ),
      ),
    );
  }
}
