import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../widgets/cart_icons.dart';
import '../../../widgets/etc/cudi_buttons.dart';
import '../../../widgets/etc/cudi_checkboxes.dart';
import '../../../widgets/etc/cudi_widgets.dart';

class CudiInfo extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const CudiInfo(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<CudiInfo> createState() => _CudiInfoState();
}

class _CudiInfoState extends State<CudiInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      88.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 668.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      if(widget.buttonClick != null) const Spacer(),
                      if(widget.buttonClick != null) Padding(
                        padding: pd2420247,
                        child: whiteButton(
                            '${widget.buttonTitle}', null, widget.buttonClick),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  List<String> titleList = [
    '상호',
    '대표이사',
    '사업자등록번호',
    '통신판매업번호',
    '호스팅 제공자',
    '주소',
    '전화번호',
    '팩스번호',
  ];
  List<String> descList = [
    'All ROUNDER(올라운더)',
    '정창훈, 한영균',
    '544-17-01958',
    '???',
    '???',
    '부산광역시 연제구 쌍미천로 89',
    '051.852.3355',
    '051.852.3351',
  ];
  Container bottomBorderContainer(int index) {
    return Container(
      decoration: index == titleList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleList[index], style: s12.copyWith(color: gray79)),
              Text(descList[index], style: s16w500),
            ],
          )),
    );
  }
}
