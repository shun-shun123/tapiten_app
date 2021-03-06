import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/answer/matching/component/matching_status_message.dart';
import 'package:tapiten_app/ui/answer/matching/matching_god_view_model.dart';

class MatchingGodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchingGodViewModel(),
      child: Scaffold(
        body: MatchingGodPageBody(),
      ),
    );
  }
}

class MatchingGodPageBody extends StatefulWidget {
  @override
  _MatchingGodPageBodyState createState() => _MatchingGodPageBodyState();
}

class _MatchingGodPageBodyState extends State<MatchingGodPageBody> {
  MatchingGodViewModel nonRebuildViewModel;
  MatchingGodViewModel rebuildViewModel;

  @override
  void initState() {
    super.initState();

    // Listen events by view model.
    nonRebuildViewModel =
        Provider.of<MatchingGodViewModel>(context, listen: false);
    nonRebuildViewModel.matchingSuccessAction.stream.listen((_) {
      Navigator.pushReplacementNamed(
        context,
        '/answer_god',
        arguments: nonRebuildViewModel.opponentId,
      );
    });

    nonRebuildViewModel.getCurrentUser();
    nonRebuildViewModel.searchingSheep();
  }

  @override
  Widget build(BuildContext context) {
    rebuildViewModel = Provider.of<MatchingGodViewModel>(context);

    return Container(
      color: Colors.white,
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
                image: AssetImage("images/sheep.png"),
              ),
            ),
          ),
          SizedBox(height: 48),
          MatchingStatusMessage(
            status: nonRebuildViewModel.status,
          ),
          Visibility(
            visible: rebuildViewModel.status == MatchingStatus.failure,
            child: Column(
              children: [
                SizedBox(height: 24),
                RaisedButton(
                  color: Color(0xffe8e8e8),
                  child: Text(
                    'もどる',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff909090),
                      fontFamily: 'RictyDiminished-Regular',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
