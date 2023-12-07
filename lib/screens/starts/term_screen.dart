import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/theme.dart';

class TermScreen extends StatefulWidget {
  final String title;
  final String term;
  final Color bgColor;
  const TermScreen({super.key, required this.title, required this.term, required this.bgColor});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  late Color textColor;
  @override
  Widget build(BuildContext context) {
    textColor = widget.bgColor == black ? white : black;
    return Scaffold(
      body: Container(
        color: widget.bgColor,
        child: Column(
          children: [
            SizedBox(height: 54.h),
            top(),
            title(),
            term(),
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
          Text('이용약관', style: s20w600.copyWith(color: textColor)),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            minWidth: 20.w,
            height: 20.h,
            child: SvgPicture.asset(
                widget.bgColor == black ? 'assets/icon/ico-line-close-default-dark-20px.svg' : 'assets/icon/ico-line-close-default-light-20px.svg'),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: widget.bgColor == black ? gray1C : grayEA)),
        ),
        child: Text(widget.title, style: s16w500.copyWith(color: textColor)));
  }

  Widget term() {
    return Flexible(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          children: [
            Text(widget.term,
                style: TextStyle(height: 1.7, color: widget.bgColor == black ? grayB5 : gray58)),
          ]),
    );
  }
}
