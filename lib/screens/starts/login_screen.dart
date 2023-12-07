import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/screens/details/find_pw_screen.dart';
import 'package:CUDI/utils/authentication.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // state variable
  late UtilProvider utilProvider;
  late bool? isEmailValid;
  late bool? isPasswordValid;
  late String _message;
  late String _userEmailId;
  String emailHintText = '이메일을 입력해주세요';
  String pwHintText = '비밀번호를 입력해주세요';

  // 파이어베이스 인증
  late Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    utilProvider = Provider.of<UtilProvider>(context);
    isEmailValid = utilProvider.isEmailValid;
    isPasswordValid = utilProvider.isPasswordValid;
    _message = utilProvider.message;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardHeight = MediaQuery.of(context).viewInsets.bottom; // 키보드 사이즈가 기기마다 일정하지 않음
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // 키보드 표시될 때 사이즈 줄어들어 버튼이 올라오면 사이즈 때문에 에러남
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: pd24h16v,
              child: cudiAppBar(context, appBarTitle: '로그인'),
            ),
            Padding(
              padding: pd24h16v,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      emailInput(context, "E-mail", emailHintText, emailController),
                      sbh24,
                      passwordInput(context, 'Password', pwHintText, passwordController),
                      validationMessage(),
                      findPassword(),
                      // Text('${auth.getUser().then((value) => debugPrint('$value'))}')
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0.h),
      child: SizedBox(
        height: 56,
        child: cudiBackgroundButton('로그인',
            isEmailValid == true && isPasswordValid == true
                ? () => submit()
                : null),
      ),
    );
  }

  Widget findPassword() {
    return _message == "아이디, 비밀번호를 확인해 주세요" ? GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FindPwScreen())),
        child: Text('비밀번호 찾기', style: s12)) : const SizedBox.shrink();
  }

  // 로그인 처리 로직
  Future submit() async {
    try {
      var userProvider = context.read<UserProvider>();
      _userEmailId =
      await auth.login(emailController.text, passwordController.text); // 파이어베이스 auth
      userProvider.setUserEmailId(_userEmailId);
      CudiProvider.getFavorites(context, _userEmailId);
      debugPrint('userEmailId $_userEmailId로 로그인');
      Navigator.pushNamed(context, RouteName.home);
      utilProvider.validateEmail('');
      utilProvider.validatePassword('');
      passwordController.text = "";
      eBeforeController.text = emailController.text;
      emailController.text = "";
    } catch (e) {
      setState(() {
        _message = "아이디, 비밀번호를 확인해 주세요";
      });
      debugPrint('Error: $e');
    }
  }
}