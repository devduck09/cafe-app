import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../utils/provider.dart';
import 'cart_screen.dart';

class MyOrderHistoryDetailScreen extends StatefulWidget {
  const MyOrderHistoryDetailScreen({super.key, required this.title});

  final String title;

  @override
  State<MyOrderHistoryDetailScreen> createState() =>
      _MyOrderHistoryDetailScreenState();
}

class _MyOrderHistoryDetailScreenState
    extends State<MyOrderHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    String userEmailId = Provider.of<UserProvider>(context).userEmailId;
    Cart cart = Provider.of<CudiProvider>(context).cart;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0.h),
                child: cudiAppBar(context,
                    appBarTitle: widget.title,
                    iconButton: cartIcon(userEmailId, cart)),
              ),
              expansions(),
            ]),
            reOrderBtn()
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
                  builder: (context) => CartScreen(
                        // storeId: cart.storeId.toString(),
                        // storeName: cart.storeName.toString(),
                        // userEmailId: userEmailId,
                      )));
        },
        child: SvgPicture.asset('assets/icon/ico-line-cart-white-24px.svg'),
      ),
    );
  }

  List orderHistoryDetailTitle = [];
  List expansionsContainers = [];

  Widget expansions() {
    expansionsContainers = <Widget>[visitTime(), orderItems(), orderInfo()];
    return SizedBox(
      height: MediaQuery.sizeOf(context).height -
          88.0 -
          83.0 -
          MediaQuery.of(context).padding.bottom -
          16.0, // 앱바, 하단 스택, 기기 패딩, 하단 여백(리스트뷰 빌더 bottom 여백)
      child: ListView.builder(
          itemCount: expansionsContainers.length,
          // itemExtent: , // 각 항목의 높이
          itemBuilder: (context, index) {
            orderHistoryDetailTitle = [
              orderHistoryDetailInfo['visitTime'] + ' 방문예정',
              '주문상품',
              '결제정보'
            ];
            return Container(
              decoration:
                  index == expansionsContainers.length ? null : boxDecoration,
              child: ExpansionTile(
                initiallyExpanded: true,
                iconColor: white,
                tilePadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
                childrenPadding:
                    const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                title: Text(
                  orderHistoryDetailTitle[index],
                  style: s16w500.copyWith(
                      height: 1.0, color: index == 0 ? primary : Colors.white),
                ),
                children: <Widget>[expansionsContainers[index]],
              ),
            );
          }),
    );
  }

  Map<String, dynamic> orderHistoryDetailInfo = {
    'visitTime': '12시 59분',
    'cafeName': 'OOU 카페',
    'barcord': 'XXXASDFGHJ1234',
    'allPrice': '23,700',
    'orderItemList': [
      {
        'itemName': 'OOU 라떼',
        'options': ['매장컵','ICED','샷추가 (1,200원)','시럽추가 (1,200원)','휘핑추가 (600원)'],
        'itemPrice': '7,500',
        'itemNum': '1',
      },
      {
        'itemName': '수정수페너',
        'options': ['매장컵', 'ICED', '샷추가 (1,200원)', '시럽추가 (1,200원)'],
        'itemPrice': '7,500',
        'itemNum': '2',
      },
    ],
    'discount': '3,000',
    'discountAdd':'회원가입 축하쿠폰 5%',
    'payment': '20,700',
    'payTool': 'CUDIPAY',
    'paymentDate': '2023년 10월 31일 15:00',
  };

  Widget visitTime() {
    return SizedBox(
      width: 390.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${orderHistoryDetailInfo['cafeName']}',
            style: s16w600.copyWith(height: 1.0),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '${orderHistoryDetailInfo['barcord']}',
            style: s12.copyWith(height: 1.6, color: grayB5),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            '${orderHistoryDetailInfo['allPrice']}원',
            style: w500.copyWith(height: 1.0),
          ),
        ],
      ),
    );
  }

  Widget orderItems() {
    List orderItemList = orderHistoryDetailInfo['orderItemList'];
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderItemList.length,
        itemBuilder: (BuildContext context, index) {
          List itemOptions = orderItemList[index]['options'];
          return Container(
            padding: EdgeInsets.only(
                bottom: index == orderItemList.length - 1 ? 0.0 : 24.0,
              top: index == 0 ? 0.0 : 24.0
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: index == orderItemList.length - 1 ? Colors.transparent : gray1C)
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(orderItemList[index]['itemName'], style: s16w600.copyWith(height: 1.0),),
                const SizedBox(height: 8.0,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemOptions.length,
                  itemBuilder: (BuildContext context, index){
                    return Text(itemOptions[index], style: s12.copyWith(height: 1.6, color: grayB5),);
                  },
                ),
                SizedBox(height: 12.0,),
                Text('${orderItemList[index]['itemPrice']}원',style: w500.copyWith(height: 1),),
                SizedBox(height: 16.0,),
                Text('수량 ${orderItemList[index]['itemNum']}개', style: s12.copyWith(height: 1,color: grayB5),),
              ],
            ),
          );
        });
  }

  Widget orderInfo() {
    // int orderitemLength = orderHistoryDetailInfo['order']
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        orderInfoItem('주문금액', '${orderHistoryDetailInfo['allPrice']}원'),
        orderInfoItem('총 메뉴 수', '${orderHistoryDetailInfo['orderItemList'].length}개'),
        orderInfoItem('할인금액', '${orderHistoryDetailInfo['discount']}원'),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(' ・ ${orderHistoryDetailInfo['discountAdd']}',style: TextStyle(height: 1.6,color: gray79),),
        ),
        orderInfoItem('결제금액', '${orderHistoryDetailInfo['payment']}원'),
        orderInfoItem('결제수단', orderHistoryDetailInfo['payTool']),
        orderInfoItem('승인일시', orderHistoryDetailInfo['paymentDate']),
      ],
    );
  }

  Widget orderInfoItem (String? title, String? add){
    return Padding(
      padding: EdgeInsets.only(bottom: title == '할인금액' ? 8.0 : 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? '', style: const TextStyle(height: 1.0, color: grayB5), ),
          Text(add ?? '', style: w500.copyWith(height: 1.0),),
        ],
      ),
    );
  }

  Widget reOrderBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: whiteButton('재주문 하러가기', null, () {}),
      ),
    );
  }

  BoxDecoration boxDecoration = const BoxDecoration(
    border: Border(
      top: BorderSide(color: gray1C),
    ),
  );
}
