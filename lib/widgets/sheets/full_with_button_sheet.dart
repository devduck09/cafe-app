import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/theme.dart';

class FullWithButtonSheet extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget button;

  const FullWithButtonSheet(
      {Key? key, required this.title, required this.body, required this.button})
      : super(key: key);

  @override
  State<FullWithButtonSheet> createState() =>
      _FullWithButtonSheetState();
}

class _FullWithButtonSheetState extends State<FullWithButtonSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        color: black,
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height - 83.h - MediaQuery.of(context).padding.bottom - 5.5,
              decoration: sheetShape,
              child: Column(
                children: [
                  SizedBox(height: h54),
                  top(),
                  widget.body,
                ],
              ),
            ),
            widget.button,
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20.w),
          Text(widget.title, style: s20w600.copyWith(color: black)),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            minWidth: 20.w,
            height: 20.h,
            child: SvgPicture.asset(
                'assets/icon/ico-line-close-default-light-20px.svg'),
          ),
          //SvgPicture.asset(
              //'assets/icon/ico-line-close-default-light-20px.svg'), // 마테레얼 버튼과 svg 그자체 여백 동일
          // SizedBox(
          //   width: 20,
          //   height: 20,
          //   child: Material(
          //     color: Colors.transparent,
          //     shape: const CircleBorder(),
          //     child: InkWell(
          //       onTap: () {},
          //       child: SvgPicture.asset(
          //           'assets/icon/ico-line-close-default-light-20px.svg'),
          //     ),
          //   ),
          // ), 마테리얼 버튼 말고 그냥 마테리얼 // 위의 마테리얼 버튼과 결과 같음
        ],
      ),
    );
  }
}
