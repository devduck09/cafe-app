import 'package:CUDI/widgets/etc/cudi_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_buttons.dart';
import '../../widgets/etc/cudi_widgets.dart';

class FindPwScreen extends StatefulWidget {
  const FindPwScreen({super.key});

  @override
  State<FindPwScreen> createState() => _FindPwScreenState();
}

class _FindPwScreenState extends State<FindPwScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pd24all,
          child: Column(
            children: [
              cudiAppBar(context, appBarTitle: "비밀번호 찾기",),
              Flexible(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    body(),
                    body2(),
                  ],
                ),
              ),
              const Spacer(),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return emailInput(context, "E-mail", "회원가입 시 등록한 이메일을 입력해 주세요.", emailController);
  }

  Widget body2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('인증 수단 선택'),
          Row(
            children: [
              Text('등록된 휴대폰 번호로 인증하기'),
              Radio(
                value: "pw",
                groupValue: _selectedAuthMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAuthMethod = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('등록된 이메일 주소로 인증하기'),
              Radio(
                value: "email",
                groupValue: _selectedAuthMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAuthMethod = value;
                  });
                },
              ),
            ],
          ),
        ],
      );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget button() {
    return Consumer<UtilProvider>(builder: (context, value, child) {
      return cudiBackgroundButton(
          "다음으로",
          Provider.of<UtilProvider>(context).isEmailValid == true
              ? () => next()
              : null);
    });
  }

  Future<void> next() async {
    // debugPrint('${textEmail.text}');
    String? userEmailId = await getUserIdByEmail(emailController.text);
    // debugPrint('$userEmailId');
    // FirebaseFirestore.instance.collection("user").doc()
    // _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
  }

  void next2() {
    sendEmail();
  }

  String? _selectedAuthMethod = "pw";

  // 이메일이 있는지 확인
  Future<String?> getUserIdByEmail(String email) async {
    try {
      // Firebase에 이메일로 사용자가 있는지 확인
      var result = await _auth.fetchSignInMethodsForEmail(email);
      debugPrint('$result');

      if (result.isNotEmpty) {
        // 사용자가 있다면 UID를 얻어옴
        var user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: "dummy_password", // 비밀번호는 필요하지만 사용자 인증에는 영향을 미치지 않습니다.
        );

        return user.user?.uid;
      } else {
        // 사용자가 없는 경우
        print("해당 이메일로 등록된 사용자가 없습니다.");
        return null;
      }
    } catch (e) {
      // 예외 처리
      print("오류 발생: $e");
      return null;
    }
  }


  // 이메일 전송
  Future sendEmail() async {
    try {
      var emailAuth = emailController.text;
      User? user = FirebaseAuth.instance.currentUser;

      // 사용자가 이미 로그인되어 있지 않은 경우 로그인
      if (user == null) {
        await FirebaseAuth.instance.signInAnonymously();
        user = FirebaseAuth.instance.currentUser;
      }

      // 사용자에게 이메일 전송
      await user!.sendEmailVerification();

      print('Successfully sent email verification to $emailAuth');
    } catch (error) {
      print('Error sending email verification: $error');
    }
  }
}

class PageWidget extends StatelessWidget {
  final Color color;
  final String text;

  PageWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}