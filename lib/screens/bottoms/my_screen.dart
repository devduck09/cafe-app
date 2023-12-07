import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/details/my_coupon_screen.dart';
import 'package:CUDI/screens/details/my_cupay_screen.dart';
import 'package:CUDI/screens/details/my/customer_center_screen.dart';
import 'package:CUDI/screens/details/my/grade_screen.dart';
import 'package:CUDI/screens/details/my/review_screen.dart';
import 'package:CUDI/screens/details/my_order_history_screen.dart';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cart_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../details/my/event_screen.dart';
import '../details/my/my_widgets.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  User user = User();

  // 파이어베이스 데이터
  void _initializeData() async {
    if (mounted) {
      user = await FireStore.getUserDoc(
          Provider.of<UserProvider>(context, listen: false).userEmailId);
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(user);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: '내 정보', isGoHome: true, iconButton: const CartIcon()),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: pd24h,
                  child: SizedBox(
                    height: 650,
                    child: Column(
                      children: [
                        profile(context, isMyScreen: true, user: user),
                        myRowList(),
                        const Divider(color: Color(0xff1C1C1C), height: 1.0),
                        SizedBox(height: 8.h),
                        myColumnList(),
                        // TextButton(
                        //     onPressed: () {
                        //       Store store = Store(
                        //         userId: widget.userEmailId,
                        //         storeName: "딥플로우브루잉 광안리점",
                        //         storeSubTitle: "딥플로우커피 광안리점 설명입니다.",
                        //         storeDescription: "자가 이용 시 카페 맞은 편 산호주차장 주차가능(30분 1500원)하며 대중교통 이용 시 금련산역 1번출구에서 광안리 해변 쪽으로 3분 도보 입니다.",
                        //         storeAddress: "부산 수영구 수영로510번길 20 딥플로우브루잉 광안리점",
                        //         storeTell: "0507-1350-4906",
                        //         storeTraffic: "",
                        //         storeHours: "11:00 - 19:00(18:30 라스트오더)",
                        //         storeClosed: "일요일",
                        //         storeParking: "산호주차장 주차가능(30분 1500원)",
                        //         storeTMap: "https://surl.tmobiapi.com/0e235207",
                        //         storeThumbnail:
                        //         "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/deep_flow_gwangalli_thumbnail.jpg",
                        //         storeImageUrl:
                        //         "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/deep_flow_gwangalli.jpg",
                        //         storeVideoUrl:
                        //         "https://3d-allrounder.com/deep_flow/3d/deep-flow.mp4",
                        //         storeThreeDUrl: "https://3d-allrounder.com/deep_flow_gwangalli/light",
                        //         storeImgList: [
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_01.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_02.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_03.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_04.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_05.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_06.jpg",
                        //           "https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/store_img_07.jpg",
                        //         ],
                        //         storeTagList: ["주차장"],
                        //       );
                        //       FireStore.addStore(store);
                        //     },
                        //     child: const Text('스토어 추가')),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget myRowList() {
    final Map<String, String> myRowListList = {
      '주문내역': 'assets/icon/ico-line-list-24px.svg',
      '쿠디페이': 'assets/icon/ico-line-cupay-24px.svg',
      '쿠폰': 'assets/icon/ico-line-cupon-24px.svg',
    };
    return Container(
      padding: EdgeInsets.only(top: 24.0.h),
      height: 144.0.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myRowListList.length,
          itemBuilder: (context, index) {
            String key = myRowListList.keys.elementAt(index);
            List<Widget> myRowWidgetList = [
              MyOrderHistoryScreen(title: key),
              const MyCupayScreen(),
              MyCouponScreen(title: key),
            ];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => myRowWidgetList[index])),
              child: SizedBox(
                width: 114.0.w,
                child: Column(children: [
                  SizedBox(
                    height: 24.0.h,
                  ),
                  SvgPicture.asset(myRowListList[key]!),
                  SizedBox(
                    height: 24.0.h,
                  ),
                  Text(key, style: w500),
                ]),
              ),
            );
          }),
    );
  }

  Widget myColumnList() {
    List<String> myColumnListList = ['이벤트', '쿠디 등급', '리뷰', '고객센터'];
    return SizedBox(
      height: 220.0,
      child: ListView.builder(
          itemCount: myColumnListList.length,
          itemBuilder: (context, index) {
            List<Widget> myColumnWidgetList = [
              MyEventScreen(title: myColumnListList[index]),
              MyGradeScreen(title: myColumnListList[index]),
              MyReviewScreen(title: myColumnListList[index]),
              CustomerCenterScreen(title: myColumnListList[index]),
            ];
            return SizedBox(
              height: 56.0.h,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0.h),
                title: Text(myColumnListList[index], style: s16w500),
                trailing: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    myColumnWidgetList[index])),
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                            'assets/icon/ico-line-arrow-right-white-24px.svg'))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => myColumnWidgetList[index]));
                },
              ),
            );
          }),
    );
  }
}
