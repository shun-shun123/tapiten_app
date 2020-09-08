import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/login/login_view_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: AppBarText(),
          backgroundColor: Colors.white,
        ),
        body: LoginForm(),
      ),
    );
  }
}

class AppBarText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'アカウント作成',
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginInfoForm(),
          Container(
            width: 200,
            margin: const EdgeInsets.all(0),
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _formKey.currentState.validate();
              },
              child: Text('作成'),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginInfoForm extends StatefulWidget {
  @override
  _LoginInfoFormState createState() => _LoginInfoFormState();
}

class _LoginInfoFormState extends State<LoginInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValidateTextInputField(
            topTitle: 'ログインID',
            obscure: false,
          ),
          Text('新規登録後、プライバシーポリシー及び\n利用規約に同意したものとします。'),
        ],
      ),
    );
  }
}

class ValidateTextInputField extends StatelessWidget {
  final String topTitle;
  final bool obscure;
  ValidateTextInputField({this.topTitle, this.obscure});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            topTitle,
            style: TextStyle(
              color: const Color(0xFF909090),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: TextFormField(
            obscureText: obscure,
            decoration: const InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE8E8E8),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide.none,
              ),
            ),

            // MEMO: 今後この画面で入力フォームが増える場合は、それぞれのフォームで validate ロジックが必要
            // 今は1つなので雛形に直接記述
            validator: (value) {
              if (value.length < 8) {
                return "8文字以上で設定してください";
              }
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

// class LoginButton extends StatelessWidget {
//   void _onPressed() {
//     print('hello');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       margin: const EdgeInsets.all(0),
//       child: RaisedButton(
//         color: Colors.grey,
//         onPressed: () {
//           _onPressed();
//         },
//         child: Text('作成'),
//         textColor: Colors.white,
//       ),
//     );
//   }
// }
