import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../utils/enum.dart';
import '../../utils/provider.dart';
import '../etc/cudi_buttons.dart';
import '../etc/cudi_widgets.dart';

class ThreeDLocalBottomSheetOpened extends StatefulWidget {
  const ThreeDLocalBottomSheetOpened({super.key});

  @override
  State<ThreeDLocalBottomSheetOpened> createState() =>
      _ThreeDLocalBottomSheetOpenedState();
}

class _ThreeDLocalBottomSheetOpenedState
    extends State<ThreeDLocalBottomSheetOpened> {
  Set<Enum> filters = {};


  @override
  Widget build(BuildContext context) {
    filters = Provider.of<SelectedTagProvider>(context).filters;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom + 54.0.h),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.bottom + 54.0.h + 72.h + 0.8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                  color: white
                ),
                child: DefaultTabController(
                  length: enumMap.keys.length, // 탭의 수
                  child: Column(
                    children: [
                      customDivider(),
                      customSheetAppBar('지역'),
                      tabBar(), // 탭바
                      tabBarView(), // 탭바뷰
                    ],
                  ),
                ),
              ),
            ),
            bottomButton(),
          ],
        ),
      ),
    );
  }

  Widget customSheetAppBar(String title) {
    return SizedBox(
      width: 390.0,
      height: 56.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: black),
            ),
          ),
          Text(title,
              style: TextStyle(
                  color: black,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1)),
          SizedBox(width: 40.w)
        ],
      ),
    );
  }

  Widget tabBar() {
    return SizedBox(
      height: 50.0.h, // TabBar 높이 설정
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: TabBar(
          physics: const RangeMaintainingScrollPhysics(),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          // TabBar를 스크롤 가능하도록 설정
          indicatorWeight: 1.0,
            labelColor: primary,
            unselectedLabelColor: gray80,
            tabs: enumMap.keys
                .map((tab) => Tab(
              child: Text(
                tagFilterLabels[tab] ?? '', // 해당하는 라벨 가져오기
                style: s16w500,
              ),
            )).toList(),
        ),
      ),
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        physics: const RangeMaintainingScrollPhysics(),
        children: enumMap.values.map((tabList) {
          return SizedBox(
            height: 500,
            child: ListView(
              physics: const RangeMaintainingScrollPhysics(),
              children: tabList.map((tabs) {
                var tabStringList = [];
                for (var tab in tabs) {
                  tabStringList.add(tagFilterLabels[tab]);
                }
                return ListTile(
                  onTap: (){
                    var selectedTagProvider = Provider.of<SelectedTagProvider>(context, listen: false);
                    for (var tab in tabs) {
                      selectedTagProvider.toggleFilter(tab);
                    }
                  },
                  title: Text(tabStringList.join(' / '), style: TextStyle(color: filters.contains(tabs[0]) ? black : gray80, fontWeight: FontWeight.w500, fontSize: 14.0)),
                  trailing: Checkbox(
                    checkColor: primary,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.selected)) {
                        return Colors.transparent;
                      }
                    }),
                    side: const BorderSide(
                      color: Colors.transparent
                    ),
                    value: filters.contains(tabs[0]),
                    onChanged: (bool? selected) {
                      var selectedTagProvider = Provider.of<SelectedTagProvider>(context, listen: false);
                      for (var tab in tabs) {
                        selectedTagProvider.toggleFilter(tab);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bottomButton() {
    return SizedBox(
      child: Container(
        color: black,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 16.0.h, 24.0, 0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 30.0,
                  )),
              const SizedBox(width: 20.0),
              Flexible(
                  child: whiteButton('적용하기', null, () {
                    Navigator.pop(context);
                  }))
            ],
          ),
        ),
      ),
    );
  }
}