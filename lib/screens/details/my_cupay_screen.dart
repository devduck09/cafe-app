import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/details/charging_history_screen.dart';
import 'package:CUDI/screens/details/reserves_screen.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/etc/cudi_buttons.dart';

class MyCupayScreen extends StatefulWidget {
  const MyCupayScreen({Key? key}) : super(key: key);

  @override
  State<MyCupayScreen> createState() => _MyCupayScreenState();
}

class _MyCupayScreenState extends State<MyCupayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: '쿠디페이',
                iconButton: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: SvgPicture.asset('assets/icon/ico-line-cart-white-24px.svg')
                ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      cudiPayProfile(),
                      smallButtons(),
                      cupayCards(),
                      cupayReserve(),
                      recentChargingHistory(),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget cudiPayProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0.h),
      child: Row(
        children: [
          SizedBox(width: 56.0, child: circleBeany(isSmail: true, size: 56)),
          SizedBox(width: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('비니님',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1)),
              SizedBox(
                height: 4.h,
              ),
              Text('cudi@cudi.com',
                  style:
                  TextStyle(color: gray79, fontSize: 14.0, height: 1.7429)),
            ],
          ),
        ],
      ),
    );
  }

  String? account;

  Widget smallButtons() {
    return SizedBox(
      height: 32.h,
      child: Row(
        children: [
          !cupayExist ? smallButton(text: '계좌등록',iconAsset: 'assets/icon/ico-line-addpaycard.svg', click: () {
                setState(() {
                  account = '';
                  cupayExist = true;
                });
          })
              : smallButton(text: '계좌삭제',iconAsset: 'assets/icon/ico-line-deletepaycard.svg', click: () {
                setState(() {
                  cupayExist = false;
                });
          }),
          !cupayExist
              ? const SizedBox()
              : smallButton(text: '계좌추가',iconAsset: 'assets/icon/ico-line-addpaycard.svg', click: () {}),
          !cupayExist
              ? const SizedBox()
              : smallButton(text: '충전하기',iconAsset: 'assets/icon/ico-line-addmoney.svg', click: () {}),
        ],
      ),
    );
  }

  Widget cupayCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: cupayExist
          ? cupayCard()
          : Container(
              height: 199,
              decoration: BoxDecoration(
                color: gray1C,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: cardInner(),
            ),
    );
  }

  Widget cardInner() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          Container(),
          const Positioned(
              child: Text('CUDIPAY',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900))),
          const Positioned(
              top: 35,
              child: Text('쿠디페이 등록하기',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700))),
          const Positioned(bottom: 25, child: Text('잔액')),
          Positioned(
              bottom: 0,
              child: priceText(
                  price: 0,
                  style: const TextStyle(fontWeight: FontWeight.w700))),
          addingCupayButton(),
        ],
      ),
    );
  }

  bool cupayExist = false;
  double _topPosition = 0;

  Widget addingCupayButton() {
    return Positioned(
        right: 0,
        top: _topPosition,
        child: InkWell(
          onTapDown: (_) {
            setState(() {
              _topPosition = 5;
            });
          },
          onTapUp: (_) {
            setState(() {
              _topPosition = 0;
              cupayExist = true;
            });
          },
          child: Image.asset(
            'assets/icon/img-membership.png',
            width: 32.0,
            height: 32.0,
          ),
        ));
  }

  Widget cupayReserve() {
    return Column(
      children: [
        containerTitle(context, text: '쿠디페이 적립금', where: const ReservesScreen()),
        cupayReserves(),
      ],
    );
  }

  List<Map<String, dynamic>> recentCharges = [
    {
      "충전금액": 50000,
      "충전날짜": "2023년 11월 05일",
      "자동일반": "자동",
    },
    {
      "충전금액": 30000,
      "충전날짜": "2023년 11월 05일",
      "자동일반": "자동",
    },
    {
      "충전금액": 10000,
      "충전날짜": "2023년 11월 05일",
      "자동일반": "일반",
    }
  ];

  Widget recentChargingHistory() {
    return Column(
      children: [
        containerTitle(context,
            text: '최근 충전 내역', where: const ChargingHistoryScreen()),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            height: 96.0.h * recentCharges.length,
            decoration: BoxDecoration(
              color: gray1C,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListView.builder(
              itemCount: recentCharges.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return recentCharge(index);
              },
            ),
          ),
        ),
        const SizedBox(height: 48.0),
      ],
    );
  }

  Widget recentCharge(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  priceText(
                      price: recentCharges[index]["충전금액"], style: s16w600),
                  Text('${recentCharges[index]["충전날짜"]}'),
                ],
              ),
              badge(index),
            ],
          ),
        ),
        divider(index),
      ],
    );
  }

  Widget badge(int index) {
    return Container(
        width: 37,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text('${recentCharges[index]["자동일반"]}', style: s12w600));
  }

  Widget divider(int index) {
    return recentCharges[index] == recentCharges.last
        ? const SizedBox()
        : const Divider(
            height: 1.0,
            color: gray2E,
            indent: 24.0,
            endIndent: 24.0,
          );
  }
}
