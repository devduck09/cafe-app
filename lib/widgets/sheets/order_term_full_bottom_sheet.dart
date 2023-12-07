import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/theme.dart';

class OrderTermFullBottomSheet extends StatefulWidget {
  final String title;
  final String term;

  const OrderTermFullBottomSheet(
      {Key? key, required this.title, required this.term})
      : super(key: key);

  @override
  State<OrderTermFullBottomSheet> createState() =>
      _OrderTermFullBottomSheetState();
}

class _OrderTermFullBottomSheetState extends State<OrderTermFullBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          SizedBox(height: 54.h),
          top(),
          title(),
          term(),
        ],
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
          Text('이용약관', style: s20w600.copyWith(color: black)),
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

  Widget title() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: grayEA)),
        ),
        child: Text(widget.title, style: s16w500.copyWith(color: black)));
        // child: Text(widget.title.substring(0, widget.title.length - 5),
        //     style: s16w500.copyWith(color: black)));
  }

  Widget term() {
    return Flexible(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          children: [
            Text(widget.term,
                style: const TextStyle(height: 1.7, color: gray58)),
          ]),
    );
  }
}
