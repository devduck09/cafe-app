import 'dart:ui';
import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Future cudiDialog (context, text, closeText) {
  return showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      title: Text(text, style: startStyle),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(closeText)),
      ],
    );
  });
}

Future cudiCupertinoDialog (BuildContext context, String title, String desc) {
  return showCupertinoDialog(barrierDismissible: true, context: context, builder: (context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent, // 배경 투명 설정
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        // 블러 효과 설정
        child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: 294.w,
              height: 196.h,
              color: black,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                      child: Column(
                        children: [
                          Text(title, style: s16w600),
                          SizedBox(height: 12.h),
                          Text(desc, textAlign: TextAlign.center, style: h17.copyWith(color: grayB5)),
                        ],
                      ),
                    ),
                    Divider(color: gray3D, height: 1.h),
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(
                                  width: 147.w,
                                  height: 56.h,
                                  child: Center(child: Text('아니오', style: s16w700))),
                            )),
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(context, RouteName.my),
                              child: SizedBox(
                                  width: 147.w,
                                  height: 56.h,
                                  child: Center(child: Text('예', style: s16w700.copyWith(color: primary)))),
                            )),
                      ],
                    ),
                  ],
                ),
              ),)
        ),
      ),
    );
    // return CupertinoAlertDialog(title: Text('비밀번호 변경완료'), content: Text('성공적으로 비밀번호가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?'), actions: [Text('아니오'), Text('예')]);
  });
}

void snackBar(BuildContext context, String message, {String? label, void Function()? click, double? margin}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.72),
        content: GestureDetector(
          onTap: click ?? (){},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text(message),
              Row(
                children: [
                  Text(label ?? ''),
                  SvgPicture.asset('assets/icon/ico-line-arrow-right-white-24px.svg', width: 16,)
                ],
              )
            ])
        ),
        duration: const Duration(milliseconds: 2000),
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: margin ?? 100),
      ),
    );
}

void showSheet(BuildContext context, Widget sheet) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: Border.all(),
    builder: (BuildContext context) {
      return sheet;
    },
  );
}