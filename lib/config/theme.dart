import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 컬러
const Color black = Color(0xff000000);
const Color white = Color(0xffFFFFFF);

const Color grayF6 = Color(0xffF6F6F7);
const Color grayEA = Color(0xffEAEAEA);
const Color grayC1 = Color(0xffC1C1C1);
const Color grayB5 = Color(0xffB5B5B6);
const Color grayA8 = Color(0xffA8A8A8);
const Color gray80 = Color(0xff808285);
const Color gray79 = Color(0xff797979);
const Color gray6F = Color(0xff6F6F6F);
const Color gray58 = Color(0xff585656);
const Color gray54 = Color(0xff545454);
const Color gray3D = Color(0xff3D3D3D);
const Color gray2E = Color(0xff2E2D2D);
const Color gray1C = Color(0xff1C1C1C);

const Color heart = Color(0xffFF4A55);
const Color error = Color(0xffFF3B30);
const Color primaryLight = Color(0xffFBD145);
const Color primary = Color(0xffD3AE5A);
const Color profileBg = Color(0xffEDC948);

// 텍스트 스타일
TextStyle startStyle = TextStyle(fontSize: 18.sp);
TextStyle loginStyle =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1);
TextStyle appBarStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
TextStyle cudiCafeDetailDescTit = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1);
TextStyle cudiCafeDetailDesc = TextStyle(
    fontSize: 13.sp, fontWeight: FontWeight.w400, color: gray58, height: 1.6);
TextStyle s12 = TextStyle(fontSize: 12.sp);
TextStyle s16 = TextStyle(fontSize: 16.sp);
const TextStyle w500 = TextStyle(fontWeight: FontWeight.w500);
TextStyle s12w600 = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
TextStyle s16w600 = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
TextStyle s16w500 = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
TextStyle s16w700 =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700);
TextStyle s20w600 = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);
TextStyle c79s12 = TextStyle(color: gray79, fontSize: 12.sp);
TextStyle c85s12h16 = TextStyle(color: grayB5, fontSize: 12.sp, height: 1.6);
const TextStyle h17 = TextStyle(height: 1.7429);
const TextStyle h19 = TextStyle(height: 1.92);
TextStyle big = TextStyle(fontWeight: FontWeight.w600, fontSize: 28.sp, height: 1.428.h);
TextStyle noticeContainerText = TextStyle(color: gray80, fontSize: 12.sp);

// 바텀 시트 모양
BoxDecoration sheetShape = const BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    ),
    color: Colors.white);

// 마테리얼 스타일
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return primary.withAlpha(150);
  }
  return white;
}

// 패딩
EdgeInsets pd24all = EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h);
EdgeInsets pd24h16v = EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w);
EdgeInsets pd24h18v = EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w);
EdgeInsets pd24T = EdgeInsets.only(top: 24.h);
EdgeInsets pd24h = EdgeInsets.symmetric(horizontal: 24.w);
EdgeInsets pd24v = EdgeInsets.symmetric(vertical: 24.h);
EdgeInsets pd2420247 = EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 7.h);
EdgeInsets pd20h16v = EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h);
EdgeInsets pd16L = EdgeInsets.only(left: 16.w);
EdgeInsets pd16v = EdgeInsets.symmetric(vertical: 16.h);
EdgeInsets pd16h20v = EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h);
EdgeInsets pd20R = EdgeInsets.only(right: 20.w);
EdgeInsets pd0 = const EdgeInsets.all(0);

// 사이즈
double h54 = 54.h;
SizedBox sbh24 = SizedBox(height: 24.h);
SizedBox sbh16 = SizedBox(height: 16.h);
SizedBox sbh12 = SizedBox(height: 12.h);
SizedBox sbh8 = SizedBox(height: 8.h);


// 컨테이너 디자인
BoxDecoration bottomBorder = const BoxDecoration(
  border: Border(
    bottom: BorderSide(color: gray1C),
  ),
);

// 테마 데이터
ThemeData theme() {
  return ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme(
        background: black,
        brightness: Brightness.light,
        primary: primary,
        onPrimary: black,
        secondary: Colors.black12,
        onSecondary: Colors.green,
        error: Colors.red,
        onError: Colors.redAccent,
        onBackground: Colors.black12,
        surface: white,
        // 스낵바 글자색
        onSurface: white),
    // 글자색
    fontFamily: 'Pretendard',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent,
      //   statusBarBrightness: Brightness.dark, // 상태 표시줄 텍스트 밝기 (밝게)
      // ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.all(0.0)),
      ),
    ),
    tooltipTheme: TooltipThemeData(
      // margin: EdgeInsets.all(10),
      showDuration: const Duration(seconds: 10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      textStyle: const TextStyle(color: Colors.white),
      preferBelow: true,
      verticalOffset: 20,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)), // 모든 패딩 제거
      ),
    ),
  );
}
