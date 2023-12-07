import 'package:CUDI/utils/authentication.dart';
import 'package:flutter/material.dart';
import '../my_home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // State-level 변수
  bool _isLogin = true;
  late String _userId;
  late String _password;
  late String _email;
  String _message = "";

  // Form Controllers
  final TextEditingController textEmail = TextEditingController();
  final TextEditingController textPassword = TextEditingController();

  // 파이어베이스 인증
  late Authentication auth;

  // 로그인 or 회원가입 처리 로직
  Future submit() async {
    // setState(() {
    //   _message = "";
    // });
    try {
      if (_isLogin) {
        _userId = await auth.login(textEmail.text, textPassword.text);
        print('$_userId로 로그인 했다!');
      } else {
        _userId = await auth.signUp(textEmail.text, textPassword.text);
        print('$_userId로 회원가입 했다!');
      }
      // if (_userId != null) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: '')));
      // }
    } catch (e) {
      print('Error: $e');
      // setState(() {
      //   _message = e.toString();
      // });
    }
  }

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                emailInput(),
                passwordInput(),
                loginButton(),
                validationMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: textEmail,
        decoration: const InputDecoration(
          hintText: '이메일',
          icon: Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          text!.isEmpty ? '이메일은 필수 입력입니다.' : '';
          setState(() {
            _message = '이메일은 필수 입력입니다';
          });
        },
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: textPassword,
        decoration: const InputDecoration(
          hintText: '비밀번호',
          icon: Icon(Icons.enhanced_encryption),
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (text) => text!.isEmpty ? '비밀번호는 필수 입력입니다.' : '',
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: submit,
          child: Text('로그인'),
        ),
      ),
    );
  }

  Widget validationMessage() {
    return Text(
      _message,
      style: TextStyle(color: Theme
          .of(context)
          .colorScheme
          .error),
    );
  }
}
