import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;
  SlidePageRoute({this.child})
      : super(
          pageBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0, 1);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
