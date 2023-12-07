import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/details/my/app_setting.dart';
import 'package:CUDI/screens/details/my/cudi_info.dart';
import 'package:CUDI/screens/details/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/etc/cudi_widgets.dart';
import '../my/email_inquiry.dart';
import 'cafe_report.dart';

class CustomerCenterScreen extends StatefulWidget {
  final String title;
  const CustomerCenterScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomerCenterScreen> createState() => _CustomerCenterScreenState();
}

class _CustomerCenterScreenState extends State<CustomerCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: widget.title),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    beanyCs(),
                    Container(
                      height: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Divider(color: gray1C,),
                    ),
                    noticeBox(),
                    csVerticalList()
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget beanyCs(){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.h),
      child: Column(
        children: [
          Image.asset('assets/images/img-cs.png', width: 109.0,height: 96.0,),
          SizedBox(height: 24.0.h,),
          Text('무엇을 도와드릴까요?',style: s20w600.copyWith(height: 1.0),),
        ],
      ),
    );
  }

  Widget noticeBox(){
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AppbarScreen(title: appbarTitleList[0], column: columnList[0]))),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 24.0.h),
          child: Container(
            height: 48.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: primary,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/img-cs-notice.png', width: 24.0,),
                    SizedBox(width: 12.0,),
                    Text('[공지]서비스 점검 안내', style: TextStyle(height: 1),)
                  ],
                ),
                Text('전체보기')
              ],
            ),
      ),
      ),
    );
  }

  Widget csVerticalList(){
    List<String> myColumnListList = ['이메일 문의', '카페 신고', '앱설정', 'CUDI 정보'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
      height: 220.0,
      child: ListView.builder(
          itemCount: myColumnListList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 56.0.h,
              child: ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  if(index == 0) {
                    return EmailInquiryScreen(title: appbarTitleList[index+1], padding: false, buttonTitle: '문의하기', buttonClick: (){});
                  } else if (index == 1) {
                    return CafeReport(title: myColumnListList[index], padding: false, buttonTitle: '제출하기', buttonClick: (){});
                  } else if (index == 2) {
                    return AppSetting(title: myColumnListList[index], padding: false);
                  } else if (index == 3) {
                    return CudiInfo(title: myColumnListList[index], padding: false);
                  } else {
                    return AppbarScreen(title: appbarTitleList[index+1], column: columnList[index+1]);
                  }
                })),
                  contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0.h),
                  title: Text(myColumnListList[index], style: s16w500),
                  trailing: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: IconButton(
                  onPressed: (){},
                  // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => myColumnWidgetList[index])),
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                            'assets/icon/ico-line-arrow-right-white-24px.svg'))),
              ),
            );
          }),
    )
    );
  }
}

/// 고객센터
List<String> appbarTitleList = ['고객센터', '이메일 문의', '카페 신고', '앱설정', 'CUDI 정보', '회원탈퇴'];
List<Column> columnList = [customerServiceCenter(), Column(), Column(), Column(), Column(), Column()];
DateTime time = DateTime.now();
String desc = 'Lorem ipsum dolor sit amet consectetur. Dolor ut nisl risus turpis. Fusce quis dictum eget semper semper. Nec erat massa consequat ullamcorper nec. Augue diam interdum a at scelerisque mollis morbi. Ac id habitant hendrerit orci lectus ornare sit id. Volutpat tellus pharetra tempus dolor. Diam gravida turpis amet aliquam gravida egestas porta a varius. Elit amet eu lobortis pulvinar duis. Arcu condimentum consectetur duis euismod amet volutpat amet ut tortor. Nulla eget tellus nulla in tellus. Cras aliquet et in pretium cursus euismod interdum. Volutpat tincidunt mattis sagittis tristique interdum ac purus sollicitudin. Varius proin duis blandit at hac. Facilisi est ut erat pharetra et a. Eu leo iaculis porta massa sagittis fermentum. Ipsum porta mauris sem pharetra nec. Non consectetur odio';
Column customerServiceCenter() {
  return Column(
    children: [
      SizedBox(
        height: 668.h,
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text('[공지] 서비스 점검 안내'),
              subtitle: Text('${time.year}년 ${time.month}월 ${time.day}일', style: s12.copyWith(color: gray79)),
                children: [
                  Text(desc,
                  style: h17.copyWith(color: grayB5)),
                ]
            );
          },),
      ),
    ],
  );
}