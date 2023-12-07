import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../widgets/cart_icons.dart';
import '../../../widgets/etc/cudi_buttons.dart';
import '../../../widgets/etc/cudi_checkboxes.dart';
import '../../../widgets/etc/cudi_inputs.dart';
import '../../../widgets/etc/cudi_widgets.dart';
import 'my_widgets.dart';

class CafeReport extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const CafeReport(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<CafeReport> createState() => _CafeReportState();
}

class _CafeReportState extends State<CafeReport> {
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
                            SizedBox(height: 668.h - 83.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
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

  List<String> titleList = ['작성자', '카페지역', '카페이름', '신고사유', "신고내용", ""];

  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [userIdWidget(), cafeAreaWidget(), cafeNameWidget(), reasonForReportWidget(reasonMap), reportDescWidget(), lastWidget()];
    return Container(
      decoration: index == widgetList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleList[index] == "" ? const SizedBox.shrink() : titleWidget(title: titleList[index]),
              titleList[index] == "" ? const SizedBox.shrink() : sbh24,
              widgetList[index]
            ],
          )),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  Widget userIdWidget(){
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${userProvider.currentUser.userNickname}님', style: w500),
        Text('${userProvider.currentUser.userEmail}', style: h19.copyWith(color: grayB5, fontSize: 12.sp)),
      ],
    );
  }

  Widget cafeAreaWidget(){
    return filledDropDownMenu(context);
  }

  String inputHint = '제목을 입력해 주세요.';
  Widget cafeNameWidget() {
    return filledTextField(controller: TextEditingController(), hintText: inputHint);
  }

  Map<String, List<String>> reasonMap = {
    '허위 정보가 포함되어 있습니다.': [
      '실제와 다른 정보 제공',
    ],
    '혜택을 이용할 수 없습니다.': [
      '쿠폰 사용 불가',
      '이벤트 참여 불가',
    ],
    '불법 정보가 포함되어 있습니다.': [
      '불법 정보 제공',
      '불법 상품 판매 및 유도',
    ],
    '청소년에게 유해한 내용이 포함되어 있습니다.': [
      '청소년에게 부적절한 내용 포함',
    ],
    '차별적/불쾌한 표현이 포함되어 있습니다.': [
      '욕설이나 타인에게 모욕감을 주는 내용 포함',
      '혐오/비하/경멸하는 내용 포함',
    ],
    '개인정보 노출 내용이 포함되어 있습니다.': [
      '타인의 개인정보 노출',
      '당사자의 동의 없이 개인을 특정지어 인지 가능한 부분',
    ],
  };


  Widget reasonForReportWidget(Map<String, List<String>> reasonMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reasonMap.entries.expand((entry) {
        return [
          checkRow(entry.key),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: entry.value.map((value) {
              return bulletText(text: value, bullet: '•');
            }).toList(),
          ),
        ];
      }).toList(),
    );
  }


  String inputDesc = '신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(50';
  Widget reportDescWidget() {
    return filledTextField(controller: TextEditingController(), hintText: inputDesc, maxLines: 20);
  }

  List<String> noticeTextList = [
    '접수된 신고 내용과 사실 확인 후 절차에 따라 조치 진행됩니다.',
    '보복성, 허위 신고 등 고객 책임으로 확인이 될 경우, 앱 내 이용 제약이 있을 수 있습니다.',
    '접수된 신고 내용은 확인 및 수정이 되지 않습니다. 신중하게 확인하시고 신고 접수부탁드립니다.',
  ];
  Widget lastWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: noticeTextList
          .map(
            (text) => bulletText(
          text: text,
          bullet: '•', // 불릿 문자
        ),
      )
          .toList(),
    );
  }
}
