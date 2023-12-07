import 'package:flutter/material.dart';
import 'package:CUDI/models/order.dart';
import 'package:CUDI/screens/details/my_order_history_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_widgets.dart';
import 'cart_screen.dart';

class MyOrderHistoryScreen extends StatefulWidget {
  final String title;

  const MyOrderHistoryScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyOrderHistoryScreen> createState() => _MyOrderHistoryScreenState();
}

class _MyOrderHistoryScreenState extends State<MyOrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    String userEmailId = Provider.of<UserProvider>(context).userEmailId;
    Cart cart = Provider.of<CudiProvider>(context).cart;

    int orderDetailListLength = 1;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: widget.title, iconButton: cartIcon(userEmailId, cart)),
            SliverList(
              delegate: SliverChildListDelegate([
                orderDetailListLength == 0 ? noContent(context, 'assets/images/img-emptystate-orderlist.png', 201.0, 136.0, '아직 주문내역이 없어요!', '궁금한 카페 3D로 구경하고 이용해봐요', '첫 주문하러 가기')
                : DefaultTabController(
                  length: 2,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 24.0),
                    height: 700,
                    child: Column(
                      children: [
                        tabBar(),
                        tabBarView(),
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

  Widget cartIcon(String userEmailId, Cart cart) {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CartScreen()));
        },
        child: SvgPicture.asset('assets/icon/ico-line-cart-white-24px.svg'),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
        labelStyle: s16w500,
        unselectedLabelColor: white,
        dividerColor: gray80,
        labelPadding: EdgeInsets.all(16.0),
        indicatorWeight: 1.0,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        tabs: [
          Text('진행 중인 주문'),
          Text('완료된 주문'),
        ]);
  }
  
  List <String> paymentItem = ['쿠페이결제', '카드결제'];

  Widget payment (){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0.h),
      child: Column(
        children: [
          SizedBox(
            height: 32.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentItem.length,
              itemBuilder: (BuildContext context, idx){
                return Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0.0,
                          backgroundColor: idx == 0 ? primary : Colors.transparent,
                          side: BorderSide(width: 1,color: idx == 0 ? Colors.transparent : gray80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            paymentItem[idx],
                            style: const TextStyle(
                                color: Colors.white,
                                height: 1,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 8.0,)
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 24.0.h,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: gray1C,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network('https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/deep_flow_gwangalli.jpg', width: 32, height: 32, fit: BoxFit.cover,),
                    SizedBox(width: 8.0,),
                    Text('자주 주문한 카페')
                  ],
                ),
                Row(
                  children: [
                    Text('전체보기', style: TextStyle(fontWeight: FontWeight.w500),),
                    SvgPicture.asset('assets/icon/ico-line-arrow-right-white-24px.svg', width: 16.0, height: 16.0,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabBarView() {
    return Expanded(
      // height: 647.h,
        child: TabBarView(
          children: [
            Column(
              children: [
                payment(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // itemCount: 10,
                    itemCount: orderDetailList.where((element) => element['condition']=='진행 중인 주문').length,
                    itemBuilder: (context, index) {
                      final filterDetailList = orderDetailList.where((element) => element['condition']=='진행 중인 주문').toList();
                      return Column(
                        children: [
                          index == 1 ? SizedBox() : detailListDate(filterDetailList[index]['date']),
                          detailListItem(filterDetailList[index]),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                payment(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderDetailList.where((element) => element['condition']=='완료된 주문').length,
                    itemBuilder: (context, index) {
                      final filterDetailList = orderDetailList.where((element) => element['condition']=='완료된 주문').toList();
                      return Column(
                        children: [
                          index == 1 ? SizedBox() : detailListDate(filterDetailList[index]['date']),
                          detailListItem(filterDetailList[index]),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
  
  List<Map<String, dynamic>> orderDetailList=[
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/hs_standard.jpg',
      'title': '황실스탠다드',// 카페 이름
      'subtitle': '황실라떼 외 1',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.10.31',
      'time':'12시 59분',//방문 시간
      'price':'23,700',//주문가격
      'payment': '쿠페이결제',// 결제 방식
      "condition": "진행 중인 주문",// 주문 상태
    },
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/deep_flow/deep_flow.jpg',
      'title': '딥플로우',// 카페 이름
      'subtitle': '초코케이크 외 1',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.10.31',
      'time':'15시 59분',//방문 시간
      'price':'12,600',//주문가격
      'payment': '카드결제',// 결제 방식
      "condition": "진행 중인 주문",// 주문 상태
    },
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/hampton/hampton.jpg',
      'title': '햄튼커피',// 카페 이름
      'subtitle': '바닐리라떼 외 1',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.9.27',
      'time':'15시 30분',//방문 시간
      'price':'18,800',//주문가격
      'payment': '카드결제',// 결제 방식
      "condition": "완료된 주문",// 주문 상태
    },
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/hs_standard.jpg',
      'title': '남산목',// 카페 이름
      'subtitle': '아메리카노 외 1',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.9.27',
      'time':'12시 00분',//방문 시간
      'price':'33,000',//주문가격
      'payment': '카드결제',// 결제 방식
      "condition": "완료된 주문",// 주문 상태
    },
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/deep_flow_gwangalli.jpg',
      'title': '딥플로우 광안점',// 카페 이름
      'subtitle': '에티오피아 구지 G1 모모라 외 1',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.8.8',
      'time':'09시 50분',//방문 시간
      'price':'18,500',//주문가격
      'payment': '쿠페이결제',// 결제 방식
      "condition": "완료된 주문",// 주문 상태
    },
    {
      'img': 'https://3d-allrounder.com/allrounder-modules/app_img/deep_flow_gwangalli/deep_flow_gwangalli.jpg',
      'title': '딥플로우 광안점',// 카페 이름
      'subtitle': '로즈부케 외 3',// 카페 주문내역
      'barcode':'',//주문번호
      'date': '2023.7.30',
      'time':'14시 25분',//방문 시간
      'price':'27,800',//주문가격
      'payment': '쿠페이결제',// 결제 방식
      "condition": "완료된 주문",// 주문 상태
    },
  ];

  Widget detailListDate (filterDetailListTime){
    return Container(
      width: 390.w,
      padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: gray3D))
      ),
      child: Text(filterDetailListTime, style: s16w500.copyWith(height: 1),),
    );
  }

  Widget detailListItem (filterDetailList){
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyOrderHistoryDetailScreen(title: '주문상세',)));},
      child: Container(
        padding: EdgeInsets.fromLTRB(24.0, 24.0.h, 24.0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network('${filterDetailList['img']}', width: 104.0.w, height: 184, fit: BoxFit.cover,),
            SizedBox(width: 16.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 222.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${filterDetailList['title']}', style: s16w600.copyWith(height: 1),),
                      SvgPicture.asset('assets/icon/ico-line-arrow-right-white-24px.svg',width: 24,height: 24,)
                    ],
                  ),
                ),
                SizedBox(height: 16.h,),
                Text('${filterDetailList['subtitle']}', style: w500.copyWith(fontSize: 14, height: 1),),
                SizedBox(height: 8.0.h,),
                Text('XXXASDFGHJ1234',style: s12.copyWith(height: 1.6, color: grayB5),),
                Text(filterDetailList['condition'] == '완료된 주문' ? '${filterDetailList['time']} 방문완료' : '${filterDetailList['time']} 방문예정',
                    style: s12.copyWith(height: 1.6, color: grayB5)),
                SizedBox(height: 12.0.h,),
                Text('${filterDetailList['price']}원', style: w500.copyWith(fontSize: 14, height: 1),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

