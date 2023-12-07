import 'package:CUDI/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/etc/cudi_buttons.dart';
import '../../widgets/etc/cudi_widgets.dart';

class PushScreen extends StatefulWidget {
  const PushScreen({super.key});

  @override
  State<PushScreen> createState() => _PushScreenState();
}

class _PushScreenState extends State<PushScreen> {
  @override
  int listLength = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: listLength == 0
            ?Column(
          children: [
            cudiAppBar(context,appBarTitle: '알림', isPadding: true),
            noContent(context, 'assets/images/img-emptystate-push.png', 96.0, 104.0, '새로운 알림이 없어요', '새로운 소식이 생기면 바로 알려드릴게요!', '알림받기')
          ],
        )
            :Column(
          children: [
            cudiAppBar(context,appBarTitle: '알림', isPadding: true),
            pushPagenation(),
            pushPageView()
          ],
        ),
      ),
    );
  }

  List<String> categoryList = ['전체', 'CUPAY', '쿠폰', '광고'];

  @override
  void initState() {
    super.initState();
    // _initializeData();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  int currentIndex = 0;
  late PageController _pageController;

  Widget pushPagenation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 390.w,
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0.h),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: gray1C, width: 1.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            categoryList.length,
            (index) => cudiNotifiHorizonListButton(categoryList[index], () {
              setState(() {
                currentIndex = index;
              });
              _pageController.jumpToPage(currentIndex);
            }, index == currentIndex),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> pushPageList = [
    {
      'pushTit': 'OOU 카페',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': 'CUPAY',
    },
    {
      'pushTit': '햄튼커피',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': 'CUPAY',
    },
    {
      'pushTit': 'DEEPFLOW',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': 'CUPAY',
    },
    {
      'pushTit': '회원가입 축하쿠폰 5% 증정',
      'pushSubTitle': '회원가입 축하 쿠폰을 증정해 드렸어요!\n내정보 - 쿠폰에서 확인할 수 있어요.',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': '쿠폰',
    },
    {
      'pushTit': 'OOU 카페 10% 쿠폰 증정',
      'pushSubTitle': 'OOU 카페에서 커피 10% 할인 쿠폰을 증정해 드렸어요.\n내정보 - 쿠폰에서 확인할 수 있어요.',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': '쿠폰',
    },
    {
      'pushTit': '(광고) IPhone15 이벤트',
      'pushSubTitle': '비니님, CUPAY로 결제하고 iPhone15 받아가세요.\n',
      //[ 수신거부 : 내정보 - 설정 ] 뒤에 넣기
      'pushTime': '오늘 오전 11:34',
      'pushCondition': '광고',
    },
    {
      'pushTit': '(광고) IPhone15 이벤트',
      'pushSubTitle': '비니님, CUPAY로 결제하고 iPhone15 받아가세요.\n',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': '광고',
    },
    {
      'pushTit': '(광고) IPhone15 이벤트',
      'pushSubTitle': '비니님, CUPAY로 결제하고 iPhone15 받아가세요.\n',
      'pushTime': '오늘 오전 11:34',
      'pushCondition': '광고',
    },
  ];

  Widget pushPageView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: PageView.builder(
            controller: _pageController,
            itemCount: categoryList.length,
            onPageChanged: (index){
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, idx) {
              final category = categoryList[idx];
              final pushCategoryList = pushPageList
                  .where((element) => element['pushCondition'] == category)
                  .toList();
              return idx == 0
                  ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                itemCount: pushPageList.length,
                    itemBuilder: (context, idx) {
                      return pushListItem(pushPageList[idx]);
                    }
              ),
                  )
                  : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: pushCategoryList.length,
                        itemBuilder: (context, idx) {
                          return pushListItem(pushCategoryList[idx]);
                        }),
                  );
            }),
      ),
    );
  }
  String imgUrl ='';
  String pushSubTitle = '';

  Widget pushListItem(pushPageList){
    if(pushPageList['pushCondition']=='쿠폰'){
      imgUrl = 'assets/images/img-push-cupon.png';
    } else if (pushPageList['pushCondition']=='CUPAY'){
      imgUrl = 'assets/images/img-push-money.png';
    } else{
      imgUrl = 'assets/images/img-push-ad.png';
    }

    if(pushPageList['pushCondition']=='쿠폰'){
      pushSubTitle = pushPageList['pushSubTitle'];
    } else if (pushPageList['pushCondition']=='CUPAY'){
      pushSubTitle = pushPageList['pushTit'] + ' 결제 완료되었습니다.';
    } else{
      pushSubTitle = pushPageList['pushSubTitle'] + '[ 수신거부 : 내정보 - 설정 ]';
    }
    return Padding(
      padding: EdgeInsets.only(top: 32.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imgUrl, width: 32.0,),
          const SizedBox(width: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pushPageList['pushCondition']=='CUPAY' ? '${pushPageList['pushTit']} 주문' :'${pushPageList['pushTit']}',
              style: TextStyle(fontWeight: FontWeight.w500,height: 1),),
              SizedBox(height: 8.0.h,),
              Text(pushSubTitle, style: TextStyle(fontSize: 12.0,height: 1.6,color: grayB5),),
              SizedBox(height: 4.0,),
              Text('${pushPageList['pushTime']}', style: TextStyle(fontSize: 12.0,height: 1,color: gray79),)
            ],
          )
        ],
      ),
    );
  }
}
