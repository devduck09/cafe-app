import 'dart:ui';

import 'package:CUDI/screens/details/screens.dart';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/etc/cudi_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../models/user.dart' as model;
import '../../../widgets/etc/cudi_util_widgets.dart';
import '../../../widgets/etc/cudi_widgets.dart';

/// 프로필 위젯
Widget profile(BuildContext context,
    {required bool isMyScreen, required model.User user}) {
  return Column(
    children: [
      sbh24,
      Stack(children: [
        if (!isMyScreen)
          const SizedBox(
            height: 96 + 8,
            width: 96 + 8,
          ),
        circleBeany(isSmail: true, size: 96),
        if (!isMyScreen)
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset('assets/icon/Frame6356926.svg'))
      ]),
      sbh24,
      InkWell(
        onTap: () {
          if (isMyScreen) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppbarScreen(
                        title: '내 정보 수정', column: editMyInformation(context))));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${user.userNickname}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, height: 1)),
            if (isMyScreen)
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: SvgPicture.asset(
                    'assets/icon/ico-line-arrow-right-white-24px.svg'),
              )
          ],
        ),
      ),
      SizedBox(
        height: 4.h,
      ),
      Text('${user.userEmail}',
          style:
              const TextStyle(color: gray79, fontSize: 14.0, height: 1.7429)),
    ],
  );
}

/// 정보 수정
Column editMyInformation(BuildContext context) {
  List<String> myList = ['기본 정보 수정', '연락처 변경', '이메일 변경', '비밀번호 변경'];
  List<Column> myWidgetList = [editBasicInformation(context), changePhone(context), changeEmail(context), changePassword(context)];
  UtilProvider utilProvider = Provider.of<UtilProvider>(context, listen: true);
  List<String> buttonTitleList = ['수정완료', utilProvider.certButtonTitle, utilProvider.certButtonTitle, '변경완료'];
  List<void Function()?> buttonFunctionList = [()=>modificationsCompleted(context), () => utilProvider.sendVerificationNumber(context, "폰"), () => utilProvider.sendVerificationNumber(context, "이메일"), ()=>changeCompleted(context)]; //sendVerificationNumber, verificationCompleted, changeCompleted];
  return Column(
    children: [
      profile(context,
          isMyScreen: false,
          user: Provider.of<UserProvider>(context, listen: false).currentUser),
      sbh24,
      const Divider(
        color: gray1C,
      ),
      ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 8.h),
        children: List.generate(myList.length, (index) {
          return myRowInkWell(context, myList[index], myWidgetList[index], buttonTitleList[index], buttonFunctionList[index]);
        }),
      )
    ],
  );
}

void modificationsCompleted(BuildContext context) {
  FireStore.userUpdate(context, Provider.of<UserProvider>(context, listen: false).userEmailId, nickName: nickNameController.text, birth: birthController.text, gender: Provider.of<UtilProvider>(context, listen: false).gender);
}

void sendVerificationNumber() {

}

void verificationCompleted() {

}

void changeCompleted(BuildContext context) async {
  auth.FirebaseAuth.instance
      .authStateChanges()
      .listen((auth.User? user) async {
    if (user != null) {
      print(user.uid);
      await user.updatePassword(pwConfirmController.text);
    }
  });
    String title = '비밀번호 변경완료';
    String desc = '성공적으로 비밀번호가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?';
    cudiCupertinoDialog(context, title, desc);
  // model.User currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
  // await auth.FirebaseAuth.instance.signInWithEmailAndPassword(email: currentUser.userEmail.toString(), password:currentUser.userPassword.toString());
  // FirebaseAuth.instance
  //     .authStateChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //     user?.updatePassword(pwConfirmController.text).then((value) {
  //       showCupertinoDialog(context: context, builder: (context) {
  //         return CupertinoAlertDialog(title: Text('비밀번호 변경완료'), content: Text('성공적으로 비밀번호가 변경되었습니다! 내 정보 페이지로 가시겠습니까?'), actions: [Text('아니오'), Text('예')],);
  //       });
  //     });
  //   }
  // });
  // await auth.FirebaseAuth.instance
  //     .sendPasswordResetEmail(email: "tccmd52@gmail.com").then((value) => debugPrint('비밀번호 재설정 메일 발송 완료')); // 유효성 검사...
}

InkWell myRowInkWell(BuildContext context, String title, Column column, String buttonTitle, buttonFunction) {
  return InkWell(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppbarScreen(title: title, column: column, buttonTitle: buttonTitle, buttonClick: buttonFunction))),
    child: SizedBox(
      height: 56.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: s16w500),
          SvgPicture.asset('assets/icon/ico-line-arrow-right-white-24px.svg')
        ],
      ),
    ),
  );
}

Column editBasicInformation(BuildContext context) {
  return Column(
    children: [
      nickNameInput(context),
      birthInput(context),
      genderInput(context),
    ],
  );
}

Column changePhone(BuildContext context) {
  return Column(
    children: [
      phoneInput(context),
      certInput(context),
    ],
  );
}

Column changeEmail(BuildContext context) {
  return Column(
    children: [
      emailInput(context, '기존 이메일', '기존 이메일을 입력하세요.', eBeforeController, enabledFalse: false),
      emailInput(context, '변경 이메일', '변경할 이메일을 입력하세요.', emailController),
      certInput(context),
    ],
  );
}

Column changePassword(BuildContext context) {
  return Column(
    children: [
      passwordInput(context, '기존 비밀번호', '비밀번호를 입력해주세요', pwBeforeController),
      passwordInput(context, '새 비밀번호', '새 비밀번호를 입력해주세요', passwordController),
      passwordInput(context, '새 비밀번호 확인', '한 번 더 입력해주세요', pwConfirmController),
      validationMessage()
    ],
  );
}

Widget titleWidget({required String title}) {
  return Text(title, style: s16w500);
}
