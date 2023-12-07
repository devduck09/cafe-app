import 'package:CUDI/screens/details/my/user_secession.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../widgets/cart_icons.dart';
import '../../../widgets/etc/cudi_buttons.dart';
import '../../../widgets/etc/cudi_checkboxes.dart';
import '../../../widgets/etc/cudi_widgets.dart';

class AppSetting extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const AppSetting(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
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
    '푸쉬알림',
    '프로모션 / 이벤트 알림 수신',
    '위치기반 정보서비스 이용약관 동의',
    'CUPAY 알림',
    '이용약관',
    '개인정보처리방침',
    '버전정보',
    '로그아웃',
    '회원탈퇴',
  ];
  Container bottomBorderContainer(int index) {
    UtilProvider utilProvider = Provider.of<UtilProvider>(context);
    List<Widget> widgetList = [
      primarySwitch(
        value: utilProvider.pushNotification,
        onChanged: (bool value) {
          utilProvider.setSwitch('pushNotification');
        },
      ),
      primarySwitch(
        value: utilProvider.promotionEventNotifications,
        onChanged: (bool value) {
          utilProvider.setSwitch('promotionEventNotifications');
        },
      ),
      primarySwitch(
        value: utilProvider.locationBasedInformationService,
        onChanged: (bool value) {
          utilProvider.setSwitch('locationBasedInformationService');
        },
      ),
      primarySwitch(
        value: utilProvider.CUPAYNotification,
        onChanged: (bool value) {
          utilProvider.setSwitch('CUPAYNotification');
        },
      ),
      IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      Text('v1.11.0', style: s16w500),
      IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      SizedBox(),
    ];
    return Container(
      decoration: index == titleList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24h16v,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: index == titleList.length-1 ? (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSecession(title: '회원탈퇴', padding: false,)));
                } : null,
                  child: Text(titleList[index], style: index == titleList.length-1 ? s16w500.copyWith(color: gray79) : s16w500)),
              widgetList[index]
            ],
          )),
    );
  }
}
