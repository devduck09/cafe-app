import 'dart:async';
import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/starts/add_profile_screen.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneCertificationScreen extends StatefulWidget {
  final List<bool> checks;
  const PhoneCertificationScreen({Key? key, required this.checks}) : super(key: key);

  @override
  State<PhoneCertificationScreen> createState() =>
      _PhoneCertificationScreenState();
}

class _PhoneCertificationScreenState extends State<PhoneCertificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 24.0),
              child: cudiAppBar(context, appBarTitle: '회원가입'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 24.0.h,),
                  certificationText(),
                  phoneInput(),
                  SizedBox(height: 48.0.h,),
                  !isSent ? SizedBox() : numberText(),
                  !isSent ? const SizedBox() : numberInput(),
                  SizedBox(height: 16.0.h,),
                  !isSent ? const SizedBox() : timeTextWidget(),
                  resendTextButton(),
                  SizedBox(height: !isSent ? 405.0.h : 313.0.h,),
                  !isSent ? certificationButton() : certificationNextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController textPhone = TextEditingController();
  final TextEditingController textNumber = TextEditingController();
  bool isPhoneInputValid = false;
  bool isSent = false;
  bool isCorrect = false;
  String _phoneNumber = '';
  late String _verificationId = '';
  String code = '';

  // int countdownSeconds = 60;
  int countdownSeconds = 180; // 3분 카운트다운 시간 (초)
  late Timer countdownTimer;
  String timeText = '';
  String resendMessage = '';
  late String uid = '인증완료전';
  String text ='전';

  @override
  void dispose() {
    countdownTimer.cancel();
    textPhone.dispose();
    textNumber.dispose();
    super.dispose();
  }

  Widget certificationText() {
    return SizedBox(
        width:390.w,
        child: Text('휴대폰 인증', style: TextStyle(fontWeight: FontWeight.w500,height: 1.0)
        ));
  }

  Widget phoneInput() {
    return TextFormField(
      controller: textPhone,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixIcon: textPhone.text.isNotEmpty
            ? InkWell(
            onTap: () => textPhone.clear(),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset('assets/icon/ico-fill-delete.svg'),
            )) : SizedBox(),
        hintText: '휴대폰 번호를 입력해 주세요.',
        hintStyle: const TextStyle(fontSize: 16.0,color: gray54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 밑줄 색상 설정
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 선택된 밑줄 색상 설정
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(17), // 최대 길이 제한 (000 - 0000 - 0000)
        FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
        PhoneNumberTextInputFormatter(), // 전화번호 형식 적용
      ],
      onChanged: (value) {
        setState(() {
          isPhoneInputValid = textPhone.text.length >= 16;
          // isPhoneInputValid = true; // 간단시험용
        });
      },
    );
  }

  Widget numberText() {
    return SizedBox(
        width:390.w,
        child: Text('인증 번호', style: TextStyle(fontWeight: FontWeight.w500,height: 1.0)
        ));
  }

  Widget numberInput() {
    return TextFormField(
      autofocus: true,
      controller: textNumber,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: '인증번호 입력',
          hintStyle: const TextStyle(fontSize: 16.0,color: gray54),
        // suffixText: timeText,
        // suffixStyle: const TextStyle(color: white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 밑줄 색상 설정
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 선택된 밑줄 색상 설정
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.length>=6) {
          setState(() {
            isCorrect = true;
          });
        } else {
          setState(() {
            isCorrect = false;
          });
        }
      },
    );
  }

  Widget timeTextWidget (){
    return SizedBox(width: 390.w, child: Text('남은 시간 $timeText', style: const TextStyle(height:1.0, color: error)));
  }

  Widget resendTextButton() {
    return Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
            onPressed: sendSMS,
            child: Text(resendMessage, style: TextStyle(color: Colors.white),),
        ),
    );
  }

  Widget certificationButton() {
    return cudiBackgroundButton(
        '인증번호 전송',
        isPhoneInputValid ? sendSMS : null);
  }

  Widget certificationNextButton() {
    return cudiBackgroundButton(
        '인증완료',
        isCorrect ? verifyCode : null);
  }

  // "인증번호 전송" 함수
  void sendSMS() {
    // 카운트 시작
    startCountdown();
    // 인증 전송 다이얼로그
    // cudiDialog(context, '인증번호가 전송되었습니다.', '닫기');
    // 폰번호 포매팅
    _phoneNumber = '+82${textPhone.text.replaceAll(' - ', '')}';
    // 파이어베이스 인증
    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.setSettings(appVerificationDisabledForTesting: true, smsCode: "123456", forceRecaptchaFlow: true); // 변화없음
    auth.verifyPhoneNumber(
      // autoRetrievedSmsCodeForTesting: const String.fromEnvironment("name1"),
        phoneNumber: _phoneNumber,
        // 인증 문자 전송
        codeSent: (String verificationId, int? resendToken) async {
          cudiDialog(context, '인증번호가 전송되었습니다. codeSent', '닫기');
          print(
              'codeSent 인증 문자 전송, verificationId: $verificationId, resendToken: $resendToken');
          _verificationId = verificationId;
        },
        // 인증 성공
        verificationCompleted: (phoneAuthCredential) async {
           cudiDialog(context, '인증번호가 수신되었습니다. verificationCompleted', '닫기');
          print(
              'verificationCompleted 인증 문자 수신, PhoneAuthCredential: $phoneAuthCredential');
        },
        verificationFailed: (FirebaseAuthException error) {
          print('verificationFailed 인증 문자 전송 실패, error: $error');
          if (error.code == 'too-many-requests') {
            cudiDialog(context, '비정상적인 활동으로 인해 이 장치의 모든 요청을 차단했습니다. 나중에 다시 시도하세요.', '닫기');
          } else {
            cudiDialog(context, '인증번호 전송에 실패하였습니다. 다시 시도해주세요. verificationFailed', '닫기');
          }
        },
        timeout: Duration(seconds: countdownSeconds),
        codeAutoRetrievalTimeout: (String verificationId) {
          cudiDialog(context, '시간이 초과되어 인증에 실패하였습니다. codeAutoRetrievalTimeout', '닫기');
          print('codeAutoRetrievalTimeout 인증 문자 시간 초과, verificationId: $verificationId');
        });
    // // PhoneAuthCredential credential = PhoneAuthProvider.credential(
    // //     verificationId: _verificationId, smsCode: code);
    // // final Future<UserCredential> authCredential =
    // //     auth.signInWithCredential(credential);
    setState(() {
      isSent = true;
    });
  }

  // "다음" 버튼을 누르면 호출되는 함수
  void verifyCode() {
    // 입력된 SMS 코드로 사용자를 인증
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: textNumber.text);
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithCredential(credential).then((authResult) {
      if (authResult.user != null) {
        // 인증이 성공한 경우
        setState(() {
          uid = authResult.user!.uid;
        });
        print('사용자 인증 성공: ${authResult.user!.uid}');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddProfileScreen(checks: widget.checks, phoneNumber: _phoneNumber, uid: uid,)));
      } else {
        // 인증이 실패한 경우
        print('사용자 인증 실패');
        cudiDialog(context, '인증에 실패하였습니다. 이 문구를 볼 경우 개발자에게 수신 요망', '닫기');
      }
    }).catchError((error) {
      print('인증 오류: $error');
      if (error.code == 'session-expired') {
        // 시간 초과된 인증 번호 오류
        cudiDialog(context, 'SMS 코드가 만료되었습니다. 다시 시도하려면 인증코드를 다시 요청하세요.', '닫기');
      } else {
        // 다른 오류 처리
        cudiDialog(context, '인증에 실패하였습니다. 번호와 코드를 확인 후 시도해주세요.', '닫기');
      }
    });
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => AddProfileScreen(checks: widget.checks, phoneNumber: _phoneNumber, uid: uid,)));
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownSeconds--; // 1초씩 감소
        if (countdownSeconds <= 0) {
          // 시간이 종료되면 타이머를 멈춥니다.
          timer.cancel();
          resendMessage = '인증번호 재전송';
        }
      });

      // 시간을 분:초 형식으로 표시합니다.
      int minutes = countdownSeconds ~/ 60;
      int seconds = countdownSeconds % 60;
      timeText = '$minutes:${seconds.toString().padLeft(2, '0')}';

      // setState(() {
      //   String timeText = '$minutes:${seconds.toString().padLeft(2, '0')}';
      // });
      // // 텍스트 필드의 suffixText를 업데이트합니다.
      // textNumber.text = timeText;
    });
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
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
      if (i == 3 || i == 7) {
        formattedText += ' - ';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
