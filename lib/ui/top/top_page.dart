import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                'images/top_image.jpg',
                )
              ],
              )

          ),
          ),
      );
  }
}