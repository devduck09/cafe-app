import 'package:CUDI/config/theme.dart';
import 'package:flutter/material.dart';

import '../../widgets/etc/cudi_widgets.dart';

class ChargingHistoryScreen extends StatefulWidget {
  const ChargingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ChargingHistoryScreen> createState() => _ChargingHistoryScreenState();
}

class _ChargingHistoryScreenState extends State<ChargingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: '쿠페이 충전내역'),
            SliverList(
              delegate: SliverChildListDelegate([
                DefaultTabController(
                  length: 2,
                  child: SizedBox(
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
          Text('일반충전'),
          Text('자동충전'),
        ]);
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount:
              charges.where((item) => item["condition2"] == "일반충전").length,
          itemBuilder: (BuildContext context, int index) {
            final filteredReserves =
                charges.where((item) => item["condition2"] == "일반충전").toList();
            return reserveTile(filteredReserves[index]);
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount:
              charges.where((item) => item["condition2"] == "자동충전").length,
          itemBuilder: (BuildContext context, int index) {
            final filteredReserves =
                charges.where((item) => item["condition2"] == "자동충전").toList();
            return reserveTile(filteredReserves[index]);
          },
        ),
      ]),
    );
  }

  List<Map<String, dynamic>> charges = [
    {
      "title": "쿠페이 충전",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 50000,
      "condition": "충전",
      "condition2": "일반충전",
    },
    {
      "title": "적립금 사용",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 30000,
      "condition": "충전",
      "condition2": "일반충전",
    },
    {
      "title": "적립금 사용",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 10000,
      "condition": "충전",
      "condition2": "일반충전",
    },
    {
      "title": "적립금 사용",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 30000,
      "condition": "충전",
      "condition2": "일반충전",
    },
    {
      "title": "적립금 사용",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 10000,
      "condition": "충전",
      "condition2": "일반충전",
    },
    {
      "title": "쿠페이 적립",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 40000,
      "condition": "충전",
      "condition2": "자동충전",
    },
    {
      "title": "쿠페이 적립",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 50000,
      "condition": "충전",
      "condition2": "자동충전",
    },
    {
      "title": "적립금 사용",
      "subtitle": "0000 0000 0000 0000",
      "three_line": "2023년 11월 12일",
      "charge_amount": 30000,
      "condition": "충전",
      "condition2": "자동충전",
    },
  ];

  ListTile reserveTile(reserve) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 16, left: 24.0, right: 24.0),
      title: Text('${reserve["title"]}', style: w500.copyWith(fontSize: 14)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Text('${reserve["subtitle"]}', style: c85s12h16),
          Text('${reserve["three_line"]} ${reserve["condition"]} 완료',
              style: c79s12),
        ],
      ),
      trailing: operatorPriceText(
          condition: reserve["condition"] == "충전", price: reserve["charge_amount"]),
    );
  }

  Widget operatorPriceText({required dynamic condition, required int price}) {
    return Text(
      '${condition ? "+" : "-"}${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
      style: w500.copyWith(color: condition ? white : gray79, fontSize: 14),
    );
  }
}
