import 'dart:async';

import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../utils/provider.dart';

// Form Controllers
final TextEditingController eBeforeController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController certController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController pwBeforeController = TextEditingController();
final TextEditingController pwConfirmController = TextEditingController();
final TextEditingController nickNameController = TextEditingController();
final TextEditingController birthController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


TextField filledTextField({required TextEditingController controller, required String hintText, int? maxLines}) {
  return TextField(
    controller: controller,
    expands: false,
    cursorColor: gray54,
    maxLines: maxLines ?? 1,
    decoration: InputDecoration(
      filled: true,
      fillColor: gray1C,
      contentPadding: pd20h16v,
      hintText: hintText,
      hintStyle: h17.copyWith(color: gray54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // 모서리 둥글기 설정
        borderSide: BorderSide.none, // 밑줄 없애기
      ),
    ),
  );
}

TextField basicTextField(
    {required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    void Function(String)? onChanged,
    bool? obscureText, List<TextInputFormatter>? formatter, bool? enabledFalse}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText ?? false,
    obscuringCharacter: '*',
    inputFormatters: formatter ?? [],
    onChanged: onChanged,
    cursorColor: white,
    enabled: enabledFalse ?? true,
    decoration: InputDecoration(
      hintText: hintText,
        hintStyle: s16.copyWith(color: gray54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 밑줄 색상 설정
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 선택된 밑줄 색상 설정
        ),
        // constraints: BoxConstraints(minHeight: 56.0, maxHeight: 56.0),
        //focusColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
        suffixIcon: suffixIcon),
  );
}

Widget validationIcon(TextEditingController controller) {
  return Consumer<UtilProvider>(
    builder: (context, provider, child) {
      bool? isValid;
      if (controller == emailController) {
        isValid = provider.isEmailValid;
      } else if (controller == eBeforeController) {
        isValid = provider.isEBeforeValid;
      } else if (controller == certController) {
        isValid = provider.isCertValid;
      } else if (controller == passwordController) {
        isValid = provider.isPasswordValid;
      } else if (controller == pwBeforeController) {
        isValid = provider.isPWBeforeValid;
      } else if (controller == pwConfirmController) {
        isValid = provider.isPWConfirmValid;
      } else if (controller == nickNameController) {
        isValid = provider.isNicknameValid;
      }  else if (controller == birthController) {
        isValid = provider.isBirthValid;
      } else if (controller == phoneController) {
        isValid = provider.isPhoneValid;
      } else {
        isValid = false;
      }
      return GestureDetector(
        onTap: () {
          if (controller.text.isNotEmpty) {
            controller.clear();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: isValid != null
              ? SvgPicture.asset(isValid
              ? 'assets/icon/ico-line-completed.svg'
              : 'assets/icon/ico-fill-delete.svg')
              : const SizedBox.shrink(), // 크기가 제로라는 사실을 명시적으로 나타냄
        ),
      );
    },
  );
}

Widget validationMessage() {
  return Consumer<UtilProvider>(
    builder: (context, utilProvider, child) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            utilProvider.message,
            style: s12.copyWith(color: error),
          ),
        ),
      );
    },
  );
}

Widget emailInput(context, String label, String hintText, TextEditingController _emailController, {bool? enabledFalse}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: w500),
        basicTextField(
          controller: _emailController,
          hintText: hintText,
          keyboardType: TextInputType.emailAddress,
          enabledFalse: enabledFalse ?? true,
          onChanged: (value) {
            if (_emailController == emailController) {
              utilProvider.validateEmail(value);
            } else if (_emailController == eBeforeController) {
              utilProvider.validateEBefore(value);
            }
          },
          suffixIcon: validationIcon(_emailController),
        ),
      ],
    ),
  );
}

Widget certInput(context) {
  return Consumer<UtilProvider>(
    builder: (context, utilProvider, child) {
      return utilProvider.isSent ? Padding(
        padding: pd24T.copyWith(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('인증 번호', style: w500),
            basicTextField(
              controller: certController,
              hintText: '인증번호를 입력해 주세요.',
              onChanged: (value) => utilProvider.validateEmail(value),
              suffixIcon: validationIcon(certController),
            ),
            sbh16,
            SizedBox(width: 390.w, child: Text('남은 시간 ${utilProvider.timeText}', style: const TextStyle(height:1.0, color: error))),
          ],
        ),
      ) : const SizedBox.shrink();
    },
  );
}

Widget passwordInput(context, String label, String hintText, TextEditingController _passwordController) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: w500),
        basicTextField(
          controller: _passwordController,
          hintText: hintText,
          obscureText: true,
          onChanged: (value) {
            if (_passwordController == passwordController) {
              utilProvider.validatePassword(value);
            } else if (_passwordController == pwBeforeController) {
              utilProvider.validatePWBefore(value, context);
            } else if (_passwordController == pwConfirmController) {
              utilProvider.validatePWConfirm(value);
            }
          },
          suffixIcon: validationIcon(_passwordController),
        ),
      ],
    ),
  );
}

Widget nickNameInput(BuildContext context) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('닉네임', style: w500),
        basicTextField(
          controller: nickNameController,
          hintText: '${userProvider.currentUser.userNickname}',
          onChanged: (value) => utilProvider.validateNickname(value),
          suffixIcon: validationIcon(nickNameController),
        ),
      ],
    ),
  );
}

Widget birthInput(BuildContext context) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('생년월일', style: w500),
        basicTextField(
          controller: birthController,
          hintText: '${userProvider.currentUser.userBirth}',
          onChanged: (value) => utilProvider.validateBirth(value),
          suffixIcon: validationIcon(birthController),
          formatter: [
              LengthLimitingTextInputFormatter(10), // 최대 길이 제한 (0000-00-00)
              // FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
              BirthTextInputFormatter(), // 생일 형식 적용
          ]
        ),
      ],
    ),
  );
}

Widget phoneInput(BuildContext context) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('휴대폰 번호', style: w500),
        basicTextField(
            controller: phoneController,
            hintText: '휴대폰 번호를 입력해 주세요.',
            onChanged: (value) => utilProvider.validatePhone(value),
            suffixIcon: validationIcon(phoneController),
            formatter: [
              LengthLimitingTextInputFormatter(11), // 최대 길이 제한 (00000000000)
              // FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
            ]
        ),
      ],
    ),
  );
}

class BirthTextInputFormatter extends TextInputFormatter {
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

Widget genderBtn (context){
  return Consumer<UtilProvider>(builder: (context, utilProvider, child) {
      return Row(
        children: [
          Expanded(
              child: SizedBox(
                height: 48.0.h,
                child: outlinedButton(
                  text: '남성',
                  click: (){
                    utilProvider.setGender('남성');
                  },
                  isSelected: utilProvider.gender == '남성',
                ),
              )
          ),
          SizedBox(width: 20.w),
          Expanded(
              child: SizedBox(
                height: 48.0.h,
                child: outlinedButton(
                  text: '여성',
                  click: (){
                    utilProvider.setGender('여성');
                  },
                  isSelected: utilProvider.gender == '여성',
                ),
              )
          ),
        ],
      );
    },
  );
}

Widget genderInput(BuildContext context) {
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('성별', style: w500),
        sbh24,
        genderBtn(context),
      ],
    ),
  );
}

Widget filledDropDownMenu(BuildContext context) {
  UtilProvider utilProvider = context.read<UtilProvider>();
  return DropdownMenu<String>(
    width: 342.w,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: gray1C,
      filled: true,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(width: 0)),
    ),
    textStyle: const TextStyle(color: grayC1),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(gray1C),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(black),
      elevation: MaterialStateProperty.all(5.0),
    ),
    initialSelection: utilProvider.selectedItem,
    onSelected: (String? value) => utilProvider.setSelectedItem(value!),
    dropdownMenuEntries: utilProvider.dropdownItems.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList(),
  );
}