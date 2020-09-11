import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/answer/matching/matching_god_page.dart';
import 'package:tapiten_app/ui/my_home/my_home_pageview.dart';
import 'package:tapiten_app/ui/my_home/viewModel/page_controller_view_model.dart';
import 'package:tapiten_app/ui/question/question/question_sheep_page.dart';
import 'package:tapiten_app/ui/tabbar/bottom_tabbar_item.dart';

class MyHomePage extends StatelessWidget {
  final myHomePageView = MyHomePageView();

  @override
  Widget build(BuildContext context) {
    var userMode = Provider.of<UserMode>(context);
    Color primaryColor = userMode.isGodFlag ? Color(0xffF8D825) : Color(0xff9FD53E);
    Color backgroundColor = userMode.isGodFlag ? Colors.white : Color(0xff909090);
    Color edgeColor = userMode.isGodFlag ? Color(0xffC7C7CC) : Colors.white;

    var pageControllerViewModel = Provider.of<PageControllerViewModel>(context);

    return Scaffold(
      backgroundColor: userMode.isGodFlag ? Colors.white : Color(0xff909090),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: userMode.isGodFlag
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(name: 'matching_god'),
                    builder: (context) {
                      return MatchingGodPage();
                    },
                    fullscreenDialog: true,
                  ),
                );
              }
            : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(name: 'question_sheep'),
                    builder: (context) {
                      return QuestionSheepPage();
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: backgroundColor,
        notchMargin: 6,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => pageControllerViewModel.changePageIndex(0),
                child: BottomTabBarItem(
                  Icons.email,
                  'メッセージ',
                  pageControllerViewModel.pageIndex == 0 ? primaryColor : edgeColor,
                ),
              ),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => pageControllerViewModel.changePageIndex(1),
                child: BottomTabBarItem(
                  Icons.person,
                  'プロフィール',
                  pageControllerViewModel.pageIndex == 1 ? primaryColor : edgeColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: myHomePageView,
    );
  }
}
