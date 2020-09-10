import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

class ProfileMessage extends StatefulWidget {
  @override
  _ProfileMessageState createState() => _ProfileMessageState();
}

class _ProfileMessageState extends State<ProfileMessage> {
  String messageText = '';

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    messageText = (viewModel.message != null) ? viewModel.message : '';

    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Text(
          messageText,
          style: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
