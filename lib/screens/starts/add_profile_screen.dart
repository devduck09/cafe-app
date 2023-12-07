import 'package:CUDI/config/theme.dart';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../utils/authentication.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_inputs.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../my_home_page.dart';

class AddProfileScreen extends StatefulWidget {
  final List<bool> checks;
  final String phoneNumber;
  final String uid;

  const AddProfileScreen(
      {Key? key,
      required this.checks,
      required this.phoneNumber,
      required this.uid})
      : super(key: key);

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  @override
  bool firstProfile = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !firstProfile ? removeFirstProfileAppBar() : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: cudiAppBar(context, appBarTitle: '회원가입'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: firstProfile ? addProfile01() : addProfile02(),
            ),
          ],
        ),
      ),
    );
  }

  String _message = "";
  bool isValidate = true;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  // 선택된 라디오 버튼의 값을 저장할 변수
  String selectedValue = '';
  DateTime date = DateTime(2016, 10, 26);

  // Form Controllers
  final TextEditingController textEmail = TextEditingController();
  final TextEditingController textPassword = TextEditingController();
  final TextEditingController textPasswordConfirm = TextEditingController();
  late TextEditingController textYear = TextEditingController();
  late TextEditingController textMonth = TextEditingController();
  late TextEditingController textDay = TextEditingController();
  late TextEditingController textNickname = TextEditingController();
  late TextEditingController textDate = TextEditingController();

  Widget removeFirstProfileAppBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0 ),
      child: SizedBox(
        height: 56.0.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 20.0,
                height: 20.0,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        firstProfile =true;
                      });
                    },
                    icon: SvgPicture.asset(
                        'assets/icon/ico-line-arrow-back-white.svg'))),
            const Text('회원가입',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(width: 20.0,height: 20.0,),
          ],
        ),
      ),
    );
  }

  Widget addProfile01() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.0.h,
        ),
        richText('E-mail'),
        emailInput(),
        SizedBox(
          height: 48.0.h,
        ),
        richText('Password'),
        passwordInput(),
        SizedBox(height: 20.0.h),
        passwordConfirmInput(),
        SizedBox(height: 287.0.h),
        // Text(widget.checks.toString() +
        //     widget.phoneNumber +
        //     widget.uid)
        validationMessage(),
        addProfileNextBtn(),
      ],
    );
  }

  Widget addProfile02() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.0.h,
        ),
        richText('닉네임'),
        nickNameInput(),
        SizedBox(
          height: 48.0.h,
        ),
        richText('생년월일'),
        dateInput(),
        SizedBox(
          height: 48.0.h,
        ),
        richText('성별'),
        SizedBox(height: 24.0.h,),
        genderBtn(context),
        SizedBox(height: 254.0.h),
        completeAddProfileButton(),
      ],
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: textEmail,
      cursorColor: Colors.white,
      decoration: inputDecoration('이메일을 입력해 주세요.').copyWith(
        suffixIcon: isEmailValid
            ? Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: SvgPicture.asset('assets/icon/ico-line-completed.svg'),
              )
            : SizedBox(),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        // 정규 표현식을 사용하여 이메일 형식 검사
        bool isValid =
            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
        setState(() {
          isEmailValid = isValid;
          if (isEmailValid) {
            _message = '이메일 형식 입력됨';
          } else {
            _message = "";
          }
        });
      },
    );
  }

  Widget passwordInput() {
    return TextFormField(
      controller: textPassword,
      decoration: inputDecoration('비밀번호를 입력해 주세요.(최소 8자리 이상)').copyWith(
        suffixIcon: isPasswordValid
            ? Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: SvgPicture.asset('assets/icon/ico-line-completed.svg'),
        )
            : SizedBox(),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (text) => text!.isEmpty ? '비밀번호는 필수 입력입니다.' : '',
      onChanged: (value) {
        // 정규 표현식을 사용하여 이메일 형식 검사
        bool isValid =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value);
        setState(() {
          isPasswordValid = isValid;
          if (isPasswordValid) {
            _message = 'password 형식 입력됨';
          } else {
            _message = "";
          }
        });
      },
    );
  }

  Widget passwordConfirmInput() {
    return TextFormField(
      controller: textPasswordConfirm,
      decoration: inputDecoration('비밀번호를 확인해 주세요.'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (text) => text!.isEmpty ? '비밀번호는 필수 입력입니다.' : '',
      onChanged: (value) {
        if (value == textPassword.text) {
          setState(() {
            _message = "비밀번호 일치";
          });
        }
      },
    );
  }

  Widget nickNameInput() {
    return TextFormField(
      controller: textNickname,
      cursorColor: Colors.white,
      decoration: inputDecoration('최대 -자리로 입력해 주세요.'),
      keyboardType: TextInputType.text,
      onChanged: (value) {},
    );
  }

  Widget dateInput() {
    return TextFormField(
        controller: textDate,
        cursorColor: Colors.white,
        decoration: inputDecoration('YYYY-MM-DD'),
        keyboardType: TextInputType.text,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10), // 최대 길이 제한 (YYYY-MM-DD)
          FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
          dateTextInputFormatter(), // 전화번호 형식 적용
        ]);
  }

  Widget addProfileNextBtn() {
    return cudiBackgroundButton('다음', () {
      setState(() {
        firstProfile = false;
      });
      // isValidate
      //     ? () async {
      //   Authentication auth = Authentication();
      //   String userEmailId = await auth.signUp(textEmail.text,textPassword.text);
      //   // SMS 아이디가 아닌 이메일 아이디 사용 (이메일로 로그인 하기 위함)
      //   var userProvider = context.read<UserProvider>();
      //   userProvider.setUserEmailId(
      //       userEmailId); // 프로바이더에 저장 (my_home_page에서 사용)
      //   User user = User(
      //     userChecks: widget.checks,
      //     userPhoneNumber: widget.phoneNumber,
      //     userId: widget.uid,
      //     userEmail: textEmail.text,
      //     userEmailId: userEmailId,
      //     userPassword: textPassword.text,
      //     userBirth: textYear.text + textMonth.text + textDay.text,
      //     userGender: selectedValue,
      //     userNickname: textNickname.text,
      //     favoriteStoreMap: {},
      //   );
      //   FireStore.addUser(user);
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => MyHomePage()));
      // }
      //     : null;
    });
  }

  Widget completeAddProfileButton() {
    return cudiBackgroundButton(
        '가입완료',
        isValidate
            ? () async {
                Authentication auth = Authentication();
                String userEmailId = await auth.signUp(
                    textEmail.text,
                    textPassword
                        .text); // SMS 아이디가 아닌 이메일 아이디 사용 (이메일로 로그인 하기 위함)
                var userProvider = context.read<UserProvider>();
                userProvider.setUserEmailId(
                    userEmailId); // 프로바이더에 저장 (my_home_page에서 사용)
                User user = User(
                  userChecks: widget.checks,
                  userPhoneNumber: widget.phoneNumber,
                  userId: widget.uid,
                  userEmail: textEmail.text,
                  userEmailId: userEmailId,
                  userPassword: textPassword.text,
                  userBirth: textYear.text + textMonth.text + textDay.text,
                  userGender: selectedValue,
                  userNickname: textNickname.text,
                  favoriteStoreMap: {},
                );
                FireStore.addUser(user);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            : null);
  }

  Widget validationMessage() {
    return Text(
      _message,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: gray54),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: white), // 밑줄 색상 설정
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: white), // 선택된 밑줄 색상 설정
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
      // suffixIcon: isEmailValid
      //     ? Padding(
      //   padding: EdgeInsets.only(left: 20.0),
      //   child: SvgPicture.asset('assets/icon/ico-line-completed.svg'),
      // )
      //     : SizedBox(),
    );
  }
}

Widget richText(String richTit) {
  return RichText(
      text: TextSpan(
          text: richTit,
          style: const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
          children: const [
        TextSpan(
          text: '*',
          style:
              TextStyle(fontWeight: FontWeight.w500, height: 1.0, color: error),
        )
      ]));
}

class dateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 입력된 값에서 숫자만 추출
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formattedText = '';
    for (var i = 0; i < newText.length; i++) {
      if (i == 4 || i == 6) {
        formattedText += '-';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}