import 'dart:math';
import 'dart:ui';
import 'package:CUDI/models/order.dart';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/sheets/order_terms_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../utils/enum.dart';
import '../../widgets/etc/cudi_buttons.dart';
import '../../widgets/etc/cudi_inputs.dart';
import '../../widgets/etc/cudi_widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List<Cart> carts = [];
  void _initializeData() async {
    late List<Cart> data;
    if (mounted) {
      data = await FireStore.getCart(UserProvider.of(context).userEmailId);
      setState(() {
        carts = data;
      });
    }

    for (Cart cart in carts) {
      amount += (cart.menuSumPrice ?? 0 ) * (cart.quantity ?? 0);
      quantity += (cart.quantity ?? 0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                cudiAppTopSpace(),
                appBar(),
                expansions(),
              ],
            ),
            stack(),
          ],
        ),
      ),
    );
  }

  Payment? _payments = Payment.cupay;
  Receipt? _receipt = Receipt.personal;
  bool isInfoSave = false;
  List expansionsContainers = [];
  List titles = [];
  List ints = [];
  List expansionsTitles = [
    '카페 방문 시간',
    '할인 적용',
    '결제 수단 선택',
    '현금 영수증 발급',
    '적립금',
    '결제정보',
  ];

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: cudiAppBar(context, appBarTitle: '주문하기'),
    );
  }

  Widget expansions() {
    expansionsContainers = <Widget>[
      container1(),
      container2(),
      container3(),
      container4(),
      container5(),
      container6(),
    ];
    return SizedBox(
      height: MediaQuery.sizeOf(context).height -
          88.0 -
          200.0 -
          MediaQuery.of(context).padding.bottom -
          16.0, // 앱바, 하단 스택, 기기 패딩, 하단 여백(리스트뷰 빌더 bottom 여백)
      child: ListView.builder(
          itemCount: expansionsContainers.length,
          // itemExtent: , // 각 항목의 높이
          itemBuilder: (context, index) {
            return Container(
              decoration: index == expansionsContainers.length - 1
                  ? null
                  : bottomBorder,
              child: ExpansionTile(
                // collapsedBackgroundColor: Colors.white24,
                initiallyExpanded: true,
                iconColor: white,
                tilePadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
                childrenPadding:
                    const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                title: Text(
                  expansionsTitles[index],
                  style: s16w500,
                ),
                children: <Widget>[expansionsContainers[index]],
              ),
            );
          }),
    );
  }

  Widget container1() {
    return Row(
      children: [
        timeButton(text: '${time.hour}시'),
        timeButton(text: '${time.minute}분'),
      ],
    );
  }

  Widget container2() {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
          color: gray1C, borderRadius: BorderRadius.circular(8.0)),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('쿠폰을 선택해 주세요', style: TextStyle(color: gray54)),
          SizedBox(
              width: 16.0,
              height: 16.0,
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.chevron_right_rounded)))
        ],
      ),
    );
  }

  Widget container3() {
    return Column(
      children: [
        Row(
          children: [
            const Text('CUPAY 결제'),
            Radio<Payment>(
              value: Payment.cupay,
              groupValue: _payments,
              onChanged: (Payment? value) {
                setState(() {
                  _payments = value;
                });
                print('groupValue: $_payments');
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: cupayCard(),
        ),
        Row(
          children: [
            const Text('카드 결제'),
            Radio<Payment>(
              value: Payment.card,
              groupValue: _payments,
              onChanged: (Payment? value) {
                setState(() {
                  _payments = value;
                });
                print('groupValue: $_payments');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget container4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('개인소등공제'),
            Radio<Receipt>(
              value: Receipt.personal,
              groupValue: _receipt,
              onChanged: (Receipt? value) {
                setState(() {
                  _receipt = value;
                });
                print('groupValue: $_receipt');
              },
            ),
          ],
        ),
        const Text('정보입력'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 48.0,
            decoration: BoxDecoration(
                color: gray1C, borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Text('연락처를 입력해 주세요.', style: TextStyle(color: gray54)),
          ),
        ),
        Row(
          children: [
            Checkbox(
                fillColor: MaterialStateProperty.all(Colors.transparent),
                checkColor: primary,
                side: const BorderSide(color: Colors.white24),
                value: isInfoSave,
                onChanged: (value) {
                  setState(() {
                    isInfoSave = !isInfoSave;
                  });
                  print('현금영수증 정보 저장: $isInfoSave');
                }),
            const Text('현금영수증 정보 저장')
          ],
        ),
        Row(
          children: [
            const Text('사업자 증빙용'),
            Radio<Receipt>(
              value: Receipt.business,
              groupValue: _receipt,
              onChanged: (Receipt? value) {
                setState(() {
                  _receipt = value;
                });
                print('groupValue: $_receipt');
              },
            ),
          ],
        ),
      ],
    );
  }

  TextEditingController textEditingController = TextEditingController();

  Widget container5() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: filledTextField(controller: textEditingController,
                  hintText: '${0.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원'),
            ),
            const SizedBox(width: 20.0),
            primaryButton('모두사용', () {}),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text('보유 적립금: ', style: s12.copyWith(color: grayB5)),
            priceText(price: 7500, style: s12.copyWith(color: grayB5)),
          ],
        ),
      ],
    );
  }

  int menuSumPrices = 0;
  int quantity = 0;
  int amount = 0;
  Widget container6() {
    TextStyle style = const TextStyle(fontWeight: FontWeight.w500);
    titles = [
      '주문금액',
      '총 메뉴 수',
      '할인금액',
    ];
    ints = [
      priceText(price: amount, style: style),
      Text('$quantity개', style: style),
      priceText(price: 0, style: style),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 98.0.h,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titles[index],
                          style: const TextStyle(color: Color(0xffB5B5B6))),
                      ints[index],
                    ],
                  ),
                );
              }),
        ),
        const Text(' ・  할인내용',
            style: TextStyle(color: gray79, fontSize: 12.0, height: 1.6)),
      ],
    );
  }

  Widget stack() {
    var style = const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('총 결제 금액',
                    style: style),
                priceText(
                    price: amount,
                    style: style),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.h, vertical: 16.0.h),
            child: whiteButton('주문하기', null, () {
              // 주문 데이터 프로바이더 저장
              String orderNumber = generateOrderNumber();
              String displayValue = (carts.length - 1 == 0) ? '' : '외 ${carts.length - 1}';
              OrderData od = OrderData(
                userEmailId: UserProvider.of(context).userEmailId,
                storeId: UserProvider.of(context).currentStore.storeId,
                orderId: orderNumber,
                orderName: '${carts[0].menuName} $displayValue',
                orderAmount: amount,
                visitingTime: time,
                menuQuantity: quantity,
                payment: _payments.toString(),
                timestamp: Timestamp.fromDate(DateTime.now()),
              );
              UserProvider.of(context).setCurrentOD(od);
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: black,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent, // 배경 투명 설정
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      // 블러 효과 설정
                      child: OrderTermsBottomSheet(orderAmount: amount),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  DateTime time = DateTime.now();

  Widget timeButton({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () async {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200.0,
                child: CupertinoDatePicker(
                  backgroundColor:
                      CupertinoColors.systemBackground.resolveFrom(context),
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: time,
                  onDateTimeChanged: (newDateTime) {
                    setState(() => time = newDateTime);
                  },
                ),
              );
            },
          );
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 52.0.w,
          height: 32.0.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: gray80)),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: grayEA, fontSize: 12.0.sp)),
        ),
      ),
    );
  }

  String generateOrderNumber() {
    const String allowedCharacters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_=';
    const int minLength = 24;
    const int maxLength = 34; // 64;

    Random random = Random();
    int length = minLength + random.nextInt(maxLength - minLength + 1);

    String orderNumber = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(allowedCharacters.length);
      orderNumber += allowedCharacters[randomIndex];
    }

    return orderNumber;
  }
}
