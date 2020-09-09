import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/answer/finish/component/return_main_screen_button.dart';
import 'package:tapiten_app/ui/answer/finish/finsh_god_view_model.dart';

class FinishGodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinishGodViewModel(),
      child: Scaffold(
        body: FinishGodPageBody(),
      ),
    );
  }
}

class FinishGodPageBody extends StatefulWidget {
  @override
  _FinishGodPageBodyState createState() => _FinishGodPageBodyState();
}

class _FinishGodPageBodyState extends State<FinishGodPageBody> {
  FinishGodViewModel viewModel;

  @override
  void initState() {
    super.initState();

    // Listen events by view model.
    viewModel = Provider.of<FinishGodViewModel>(context, listen: false);
    viewModel.matchingSuccessAction.stream.listen((_) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
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
                image: AssetImage("images/god.png"),
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(
            '神様お疲れ様でした',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xff909090),
              fontFamily: 'RictyDiminished-Regular',
            ),
          ),
          SizedBox(height: 140),
          ReturnMainScreenButton(onPressed: viewModel.returnMainScreen),
        ],
      ),
    );
  }
}
