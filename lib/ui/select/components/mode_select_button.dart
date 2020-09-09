import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModeSelectButton extends StatelessWidget {
  final Function onPressed;
  final Image icon;
  final Color borderColor;

  ModeSelectButton({
    @required this.onPressed,
    @required this.icon,
    @required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2.0),
          shape: BoxShape.circle,
        ),
        child: IconButton(icon: icon, onPressed: onPressed, iconSize: 100.0),
      ),
    );
  }
}
