import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/select/select_view_model.dart';

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Injects HomeViewModel into this widgets.
        ChangeNotifierProvider(create: (_) => SelectViewModel()),
      ],
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Select"),
        // ),
        body: SelectPageBody(),
      ),
    );
  }
}

class SelectPageBody extends StatefulWidget {
  @override
  _SelectPageBodyState createState() => _SelectPageBodyState();
}

class _SelectPageBodyState extends State<SelectPageBody> {
  @override
  void initState() {
    super.initState();

    // Listen events by view model.
    //var viewModel = Provider.of<SelectViewModel>(context, listen: false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'どちらを選びますか',
              ),
              SizedBox(
                height: 100.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      IconButton(
                        onPressed:
                            Provider.of<SelectViewModel>(context).selectGodMode,
                        icon: Image.asset('images/god_circle.png'),
                        iconSize: 100.0,
                      ),
                      Text('神さま'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: Provider
                            .of<SelectViewModel>(context)
                            .selectSheepMode,
                        icon: Image.asset('images/sheep_circle.png'),
                        iconSize: 100.0,
                      ),
                      Text('仔羊'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'どちらのモードも後ほど変更可能です。',
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                child: Text(
                  '世界へ行く',
                ),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }
}
