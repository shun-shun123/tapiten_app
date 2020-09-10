import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/question/matching/matching_sheep_view_model.dart';

import 'component/matching_status_message.dart';

class MatchingSheepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchingSheepViewModel(),
      child: Scaffold(
        body: MatchingSheepPageBody(),
      ),
    );
  }
}

class MatchingSheepPageBody extends StatefulWidget {
  @override
  _MatchingSheepPageBodyState createState() => _MatchingSheepPageBodyState();
}

class _MatchingSheepPageBodyState extends State<MatchingSheepPageBody> {
  MatchingSheepViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<MatchingSheepViewModel>(context, listen: false);

    viewModel.getCurrentUser();
    viewModel.matchingWithGod();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff909090),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/god.png"),
              ),
            ),
          ),
          SizedBox(height: 60),
          MatchingStatusMessage(
            status: viewModel.status,
          ),
          SizedBox(height: 36),
          Visibility(
            visible: viewModel.status == SheepMatchingStatus.complete,
            child: RaisedButton(
              color: Colors.white,
              child: Text(
                '確認する',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff909090),
                  fontFamily: 'RictyDiminished-Regular',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/finish_sheep');
              },
            ),
          ),
        ],
      ),
    );
  }
}
