import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';

class MessageDetailPageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    return Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: userMode.isGodFlag
              ? AssetImage("images/sheep.png")
              : AssetImage("images/god.png"),
        ),
      ),
    );
  }
}
