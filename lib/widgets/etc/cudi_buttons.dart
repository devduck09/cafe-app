import 'package:CUDI/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

ElevatedButton outlinedButton({required String text, void Function()? click, required bool isSelected}) {
  return ElevatedButton(
    onPressed: click,
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      backgroundColor: isSelected ? primary : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: isSelected ? primary : gray80,
          width: 1,
        ),
      ),
    ),
    child: Text(text, style: w500.copyWith(color: Colors.white, height: 1.0)),
  );
}

Widget launchFillButton(String text, void Function()? click) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      side: BorderSide(
        width: 1.0,
        color: Colors.white,
      ),
      backgroundColor: Colors.white,
      textStyle: loginStyle,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
      // 버튼 패딩 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // 모서리를 둥근 직사각형으로 설정
      ),
    ),
    onPressed: click,
    child: Text(text,
        style: TextStyle(color: click != null ? Colors.black : gray6F)),
  );
}

Widget launchLineButton(String text, void Function()? click, {bool? bgWhite}) {
  return Flexible(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
          width: 1.0,
          color: white,
        ),
        backgroundColor: bgWhite != null ? white: black,
        textStyle: loginStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: click,
      child: Padding(
        padding: pd24h18v,
        child: Center(
          child: Text(text,
              style: TextStyle(color: click != null ? bgWhite != null ? black : white : gray6F)),
        ),
      ),
    ),
  );
}

Widget cudiBackgroundButton(String text, void Function()? click) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: white,
      disabledBackgroundColor: Colors.transparent,
      textStyle: loginStyle,
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      minimumSize: const Size(400, 56),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(
            color: Color(0xff3D3D3D),
          )),
    ),
    onPressed: click,
    child: Text(text,
        style: TextStyle(
            color: click != null ? black : gray6F,
            fontWeight: FontWeight.w700)),
  );
}

// Widget viewCafeButtonDark(String text, void Function()? click) {
//   return Container(
//     padding: EdgeInsets.all(5.0),
//     height: 42.5,
//     child: ElevatedButton(
//       onPressed: click,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(0.0),
//         backgroundColor: cudiDark,
//         textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
//         minimumSize: Size(100.0, 42.5),
//         // 최소 크기를 설정
//         maximumSize: Size(100.0, 42.5),
//         // 최대 크기를 설정 (최소 크기와 동일하게 설정하여 크기를 고정)
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0), // 모서리를 둥근 직사각형으로 설정
//         ),
//         elevation: 0.0,
//       ),
//       child: Text(text),
//     ),
//   );
// }

// Widget viewCafeButtonDarkLarge(String text, void Function()? click) {
//   return Container(
//     // padding: EdgeInsets.all(5.0),
//     height: 45.0,
//     child: ElevatedButton(
//       onPressed: click,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 15.0),
//         backgroundColor: cudiDark,
//         textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//         // minimumSize: Size(50.0, 42.5),
//         // // 최소 크기를 설정
//         maximumSize: Size(125.0, 45.0),
//         // 최대 크기를 설정 (최소 크기와 동일하게 설정하여 크기를 고정)
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0), // 모서리를 둥근 직사각형으로 설정
//         ),
//         elevation: 0.0,
//       ),
//       child: Text(text),
//     ),
//   );
// }

// Widget viewCafeIconButtonDark(Icon icon, void Function()? click) {
//   return Container(
//     height: 30.0,
//     width: 30.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5.0),
//       color: cudiDark,
//     ),
//     child: IconButton(onPressed: click, icon: icon, padding: EdgeInsets.zero),
//   );
// }

Widget popButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 60, 0, 0),
    child: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 16.0,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget cudiHorizonListButton(
    String text, String icon, void Function()? click, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.only(right: 6.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: isSelected ? white : gray2E,
        // 기본 배경 색상을 흰색으로 설정하고 select되면 흰색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          // side: BorderSide(
          //   color: isSelected ? primary : Colors.white, // 테두리 컬러 조정
          // ),
        ), // 모서리를 둥근 직사각형으로 설정
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 14.0,
            height: 14.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: isSelected ? gray2E : gray79,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget menuHorizonListButton(
    String text, void Function()? click, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.only(right: 6.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: isSelected ? primary : white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? Colors.white : grayEA,
              width: 1,
            )),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: isSelected ? white : gray80,
        ),
      ),
    ),
  );
}

Widget cudiNotifiHorizonListButton(
    String text, void Function()? click, bool isSelected) {
  return Container(
    height: 32.0,
    padding: const EdgeInsets.only(right: 8.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        elevation: 0.0,
        backgroundColor: isSelected ? primary : Colors.transparent,
        // 배경 색상을 흰색으로 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: isSelected ? primary : gray80, // 테두리 컬러 조정
          ),
        ), // 모서리를 둥근 직사각형으로 설정
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          height: 1,
          color: isSelected?Colors.white : grayEA, // 텍스트 색상을 검정색으로 설정
        ),
      ),
    ),
  );
}

Widget viewCafeHorizonListButton(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // textStyle: TextStyle(fontWeight: ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: primary, // 테두리 컬러 조정
            width: 1.2,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: primary, // 텍스트 색상을 검정색으로 설정
        ),
      ),
    ),
  );
}

FilledButton whiteButton(String text, dynamic icon, void Function()? click) {
  return FilledButton(
    style: ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(0,56.h)),
      backgroundColor: MaterialStatePropertyAll(white),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)))
    ),
    onPressed: click,
    child: Row(
      mainAxisAlignment: icon != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        Text(text, style: s16w700),
        icon != null ? Image.asset(icon, width: 20.w, height: 20.h) : const SizedBox(),
      ],
    ),
  );
}

Widget orderHotOrIcedButton(
    String text, void Function()? click, bool isSelected) {
  return Container(
    // padding: const EdgeInsets.only(right: 20.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: isSelected ? primary : white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? white : Color(0xffEAEAEA),
              width: 1,
            )),
        // padding: EdgeInsets.zero,
        //   maximumSize: Size(161.0, 40.0),
        // minimumSize: Size(161.0, 40.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: isSelected ? white : Color(0xff808285),
        ),
      ),
    ),
  );
}

Widget smallButton({required String text, void Function()? click, String? iconAsset}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: const TextStyle(color: grayEA, fontSize: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
        // 버튼 패딩 설정
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.0,
            color: gray80,
          ),
          borderRadius: BorderRadius.circular(8.0), // 모서리를 둥근 직사각형으로 설정
        ),
      ),
      onPressed: click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child:
            Row(
              children: [
                SvgPicture.asset(iconAsset ?? '', width: 8.0,),
                SizedBox(width: 4.0,),
                Text(text, style: TextStyle(color: click != null ? white : gray6F)),
              ],
            ),
      ),
    ),
  );
}

Widget primaryButton(String text, VoidCallback click) {
  return FilledButton(
      onPressed: click,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size(100.0, 48.0)),
        // 버튼 높이 설정
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // 글자색
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기 설정
          ),
        ),
      ),
      child: Text(text, style: w500));
}
