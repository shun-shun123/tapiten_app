import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/select/select_view_model.dart';
import 'package:tapiten_app/ui/message/message_page.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/select/components/mode_select_button.dart';
import 'package:tapiten_app/main.dart';

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
  int _selectedModeIndex;
  @override
  void initState() {
    super.initState();

    // Listen events by view model.
    //var viewModel = Provider.of<SelectViewModel>(context, listen: false);
  }

  void selectMode(int selectedModeIndex) {
    setState(() {
      _selectedModeIndex =
          _selectedModeIndex != selectedModeIndex ? selectedModeIndex : 0;
    });
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
                      ModeSelectButton(
                        onPressed: () {
                          // MEMO: ここで Prodiver を呼ぶと、警告が出て実行されなかったので直接実行
                          // MVVM にするためには調査が必要
                          UserMode.isGod = true;
                          print('isGod is changed to true');
                          selectMode(0);
                        },
                        icon: Image.asset('images/god.png'),
                        borderColor: _selectedModeIndex == 0
                            ? Colors.black
                            : Colors.white,
                      ),
                      Text('神さま'),
                    ],
                  ),
                  Column(
                    children: [
                      ModeSelectButton(
                        onPressed: () {
                          UserMode.isGod = false;
                          print('isGod is changed to false');
                          selectMode(1);
                        },
                        icon: Image.asset('images/sheep.png'),
                        borderColor: _selectedModeIndex == 1
                            ? Colors.black
                            : Colors.white,
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
                onPressed: () {
                  print('Current isGod flag is :${UserMode.isGod}');
                  // TODO: 遷移先の Message ページのエラーが治ったらコメントイン
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
