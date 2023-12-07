import 'package:CUDI/screens/details/my/my_widgets.dart';
import 'package:CUDI/widgets/etc/cudi_checkboxes.dart';
import 'package:CUDI/widgets/etc/cudi_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme.dart';
import '../../../widgets/cart_icons.dart';
import '../../../widgets/etc/cudi_buttons.dart';
import '../../../widgets/etc/cudi_widgets.dart';

class UserSecession extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const UserSecession(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<UserSecession> createState() => _UserSecessionState();
}

class _UserSecessionState extends State<UserSecession> {
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
    '',
    '기타',
    '비밀번호 입력',
    '',
  ];
  String hintText = '서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스';
  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [
      secessionCheckBoxes(),
      filledTextField(controller: TextEditingController(), hintText: hintText, maxLines: 4),
      filledTextField(controller: TextEditingController(), hintText: ''),
      secessionButtons(),
    ];
    return Container(
      decoration: index == titleList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(title: titleList[index]),
              sbh24,
              widgetList[index],
            ],
          )),
    );
  }

  Widget secessionCheckBoxes(){
    return Column(
      children: [
        secessionCommonWidget(),
      ],
    );
  }

  String textVariable = 'CUDI를 떠나신다니 아쉬워요.\n무엇이 불편하셨나요?';
  String textVariable2 = '계속 진행하시면\n혜택이 완전히 사라져요.';
  List<String> inconvenienceList = [
    '카페 이용을 잘 안 해요.',
    '앱 사용을 잘 안 해요.',
    '혜택(쿠폰, 이벤트)이 너무 적어요.',
    '개인정보보호를 위해 삭제할 정보가 있어요.',
    '다른 계정이 있어요.',
  ];
  Widget secessionCommonWidget() {
    return Column(
      children: [
        Image.asset('assets/images/img-cs-out1.png', width: 24),
        bigText(textVariable),
        ...inconvenienceList.map((e) => checkRow(e)).toList(),
      ],
    );
  }

  Widget secessionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        launchLineButton('탈퇴취소', (){}),
        SizedBox(width: 20.w),
        launchLineButton('다음으로', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSecession2(title: '회원탈퇴'))), bgWhite: true),
      ],
    );
  }
}

class UserSecession2 extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const UserSecession2(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<UserSecession2> createState() => _UserSecession2State();
}

class _UserSecession2State extends State<UserSecession2> {
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height -
                      88.h -
                      MediaQuery
                          .of(context)
                          .padding
                          .top -
                      MediaQuery
                          .of(context)
                          .padding
                          .bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 668.h, child: columnWidget()),
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

  String textVariable = '계속 진행하시면\n혜택이 완전히 사라져요.';
  List<String> inconvenienceList = [
    '카페 이용을 잘 안 해요.',
    '앱 사용을 잘 안 해요.',
    '혜택(쿠폰, 이벤트)이 너무 적어요.',
    '개인정보보호를 위해 삭제할 정보가 있어요.',
    '다른 계정이 있어요.',
  ];

  Column columnWidget() {
    int data1 = 5600;
    String? data2;
    int data3 = 3;
    Map<String, List<dynamic>> secessionMap = {
      'CUPAY' : [
        'assets/images/img-point.png',
        data1
      ],
      '등급' : [
        'assets/images/img-point.png',
        (data2 ?? '???')
      ],
      '쿠폰' : [
        'assets/images/img-point.png',
        '$data3장'
      ],
    };

    List<Widget> secessionWidgets = [];

    secessionMap.forEach((key, value) {
      secessionWidgets.add(secessionContainer(key: key, url: value[0], value: value[1]));
    });

    List<String> secessionBulletTextList = [
      '탈퇴 후 회원님의 등급과 쿠폰들은 복구가 불가능합니다.',
      '잔여 CUPAY는 자동 환불되지 않습니다. 탈퇴 전 환불 진행해 주세요.',
      '등록된 리뷰는 자동으로 삭제되지 않습니다. 탈퇴 전 개별적으로 삭제해 주세요.',
      '계정 정보 및 찜 목록 등 서비스 이용정보는 복구가 불가능하며, 동일한 아이디로 24시간 이후 재가입이 가능합니다.',
    ];

    return Column(
      children: [
        Image.asset('assets/images/img-cs-out1.png', width: 24),
        bigText(textVariable),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...secessionWidgets]
          ),
        ),
        sbh24,
        ...secessionBulletTextList.map((e) => bulletText(text: e, bullet: '•')),
        sbh24,
        checkRow('[필수]위 주의사항을 모두 숙지했으며 탈퇴에 동의합니다.'),
      ],
    );
  }

  Widget secessionContainer({required String url, required String key, dynamic value}) {
    return Container(
      width: 100.6.w,
      padding: pd16h20v,
      decoration: BoxDecoration(
        color: gray1C,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Image.asset(url, width: 48.w),
          sbh12,
          Text(key, style: w500),
          sbh8,
          Center(child: key == "CUPAY" ? priceText(price: value, style: s16w600) : Text('$value', style: s16w600))
        ],
      ),
    );
  }
}
