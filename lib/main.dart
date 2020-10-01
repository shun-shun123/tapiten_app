import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/storage/user_id.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/answer/finish/finish_god_page.dart';
import 'package:tapiten_app/ui/answer/matching/matching_god_page.dart';
import 'package:tapiten_app/ui/my_home/my_home_page.dart';
import 'package:tapiten_app/ui/my_home/viewModel/page_controller_view_model.dart';
import 'package:tapiten_app/ui/question/finish/finish_sheep_page.dart';
import 'package:tapiten_app/ui/question/matching/matching_sheep_page.dart';
import 'package:tapiten_app/ui/question/question/question_sheep_page.dart';
import 'package:tapiten_app/ui/top/top_page.dart';
import 'package:tapiten_app/view/god_answer_page/view/answer_god_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager.initialize();

  // await signOut();
  await loadUserMode();
  await loadUserId();
  // await forceQuitApp();

  runApp(MyApp());
}

// ローカルに保存したUserModeを読み出す
// 初回起動時はデフォルト設定で神さまモードがセットされます
Future loadUserMode() async {
  var userMode = UserMode();
  await userMode.loadUserMode();
  print('This user uses as ${UserMode.isGod ? 'God-mode' : 'Sheep-mode'}');
}

// ローカルに保存したUserIdを読み出す
// 初回起動時は''が返ってきます
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

// FirebaseAuthからサインアウトします
// デバッグ用に使用してください
Future signOut() async {
  await FirebaseAuth.instance.signOut().then((value) => print('signOut'));
  var userId = UserId();
  userId.saveUserId(id: '');
}

// 強制的にアプリを終了させます
Future forceQuitApp() async {
  await SystemNavigator.pop(animated: true)
      .then((value) => {print('finished pop')});
}

class MyApp extends StatelessWidget {
  // すでにログイン済みかの判定を行う
  bool isLoggedInFirebase(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserMode>(
          create: (context) => UserMode(),
        ),
        ChangeNotifierProvider<PageControllerViewModel>(
          create: (context) => PageControllerViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: isLoggedInFirebase(context) ? '/' : '/top',
        routes: {
          '/': (context) => MyHomePage(),
          '/top': (context) => TopPage(),
          '/matching_god': (context) => MatchingGodPage(),
          '/answer_god': (context) => AnswerGodPage(),
          '/finish_god': (context) => FinishGodPage(),
          '/question_sheep': (context) => QuestionSheepPage(),
          '/matching_sheep': (context) => MatchingSheepPage(),
          '/finish_sheep': (context) => FinishSheepPage(),
        },
      ),
    );
  }
}
