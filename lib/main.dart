import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/answer/answer_god_page.dart';
import 'package:tapiten_app/ui/answer/finish_god_page.dart';
import 'package:tapiten_app/ui/answer/matching_god_page.dart';
import 'package:tapiten_app/ui/login/sign_in_with_google.dart';
import 'package:tapiten_app/ui/message/message_page.dart';
import 'package:tapiten_app/ui/profile_god/profile_god_page.dart';
import 'package:tapiten_app/ui/tabbar/bottom_tabbar_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirestoreManager.initialize();

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
  if (UserId.userId == '') {
    print('This user does NOT have a userId in local storage.');
  } else {
    print('This users userId is ${UserId.userId}');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      // home: MyHomePage(),
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
      final user = _auth.currentUser;
      print(user);
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SigninWithGoogle()),
        );
      }
    } catch (e) {
      print(e);
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF8D825),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              settings: const RouteSettings(name: 'matching_god'),
              builder: (context) {
                return MatchingGodPage();
              },
              fullscreenDialog: true,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
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
                  currentPageIndex == 0 ? Color(0xffF5DB28) : Color(0xff909090),
                ),
              ),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => changePage(1),
                child: BottomTabBarItem(
                  Icons.person,
                  'プロフィール',
                  currentPageIndex == 1 ? Color(0xffF5DB28) : Color(0xff909090),
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
          ProfileGodPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
