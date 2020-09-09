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
  MatchingGodViewModel viewModel;

  @override
  void initState() {
    super.initState();

    // Listen events by view model.
    viewModel = Provider.of<MatchingGodViewModel>(context, listen: false);
    viewModel.matchingSuccessAction.stream.listen((_) {
      Navigator.pushReplacementNamed(
        context,
        '/answer_god',
        arguments: viewModel.opponentId,
      );
    });

    viewModel.getCurrentUser();
    viewModel.searchingSheep();
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 60),
          MatchingStatusMessage(
            status: viewModel.status,
          ),
        ],
      ),
    );
  }
}
