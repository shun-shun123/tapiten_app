import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/answer/answer/answer_god_page.dart';
import 'package:tapiten_app/ui/answer/finish/finish_god_page.dart';
import 'package:tapiten_app/ui/answer/matching/matching_god_page.dart';
import 'package:tapiten_app/ui/login/sign_in_with_google.dart';
import 'package:tapiten_app/ui/message/message_page.dart';
import 'package:tapiten_app/ui/profile/profile_page.dart';
import 'package:tapiten_app/ui/question/finish/finish_sheep_page.dart';
import 'package:tapiten_app/ui/question/matching/matching_sheep_page.dart';
import 'package:tapiten_app/ui/question/question/question_sheep_page.dart';
import 'package:tapiten_app/ui/tabbar/bottom_tabbar_item.dart';
import 'package:tapiten_app/ui/top/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager.initialize();

  await loadUserMode();
  await loadUserId();

  runApp(MyApp());
}

Future loadUserMode() async {
  var userMode = UserMode();
  await userMode.loadUserMode();
  print('This user uses as ${UserMode.isGod ? 'God-mode' : 'Sheep-mode'}');
}

Future loadUserId() async {
  var userId = UserId();
  await userId.loadUserId();
  // StringIsNullOrEmpty
  if (UserId.userId == null || UserId.userId == '') {
    print('This user does NOT have a userId in local storage.');
  } else {
    print('This users userId is ${UserId.userId}');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserMode>(
      create: (_) => UserMode(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/matching_god': (context) => MatchingGodPage(),
          '/answer_god': (context) => AnswerGodPage(),
          '/finish_god': (context) => FinishGodPage(),
          '/question_sheep': (context) => QuestionSheepPage(),
          '/matching_sheep': (context) => MatchingSheepPage(),
          '/finish_sheep': (context) => FinishSheepPage(),
        },
        // home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _myPage = PageController(initialPage: 0);
  int currentPageIndex = 0;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkLoggedInFirebase();
  }

  void checkLoggedInFirebase() async {
    try {
      final isLogIn = _auth.currentUser != null;  // ログイン済みか　
      final hasAccount = UserId.userId != null && UserId.userId != ''; // IsNotNullAndEmpty
      if (isLogIn) {
        return;
      } else if (hasAccount) {  
        // ログインはしてないけどアカウントは持ってる
        // TODO: ログインページへ行きたい
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TopPage()),
        );
      } else {
        // ログインもしてないし、アカウントすら持っていない
        // TODO: サインアップページへ行きたい
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => TopPage()),
        );
      }
    } catch (e) {
      // せめてもの情けでログだけ出力
      print(e);
      // 何もみなかったことにしてアプリをそっと落とそう（🤔）
      await SystemNavigator.pop();
    }
  }

  void changePage(int pageIndex) {
    setState(
      () {
        _myPage.jumpToPage(pageIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = UserMode.isGod ? Color(0xffF8D825) : Color(0xff9FD53E);
    Color backgroundColor = UserMode.isGod ? Colors.white : Color(0xff909090);
    Color edgeColor = UserMode.isGod ? Color(0xffC7C7CC) : Colors.white;
    return Scaffold(
      backgroundColor: Provider.of<UserMode>(context).isGodFlag ? Colors.white : Color(0xff909090),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: UserMode.isGod
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
                onTap: () => changePage(0),
                child: BottomTabBarItem(
                  Icons.email,
                  'メッセージ',
                  currentPageIndex == 0 ? primaryColor : edgeColor,
                ),
              ),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => changePage(1),
                child: BottomTabBarItem(
                  Icons.person,
                  'プロフィール',
                  currentPageIndex == 1 ? primaryColor : edgeColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (int _currentPageIndex) {
          currentPageIndex = _currentPageIndex;
        },
        children: <Widget>[
          MessagePage(
            // TODO: 神様or子羊判定のフラグをここで代入する
            isGod: true,
          ),
          ProfilePage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
