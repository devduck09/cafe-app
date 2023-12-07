import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/menu.dart';
import '../../utils/firebase_firestore.dart';
import '../../utils/provider.dart';
import '../etc/cudi_widgets.dart';

class MenuBottomSheetOpened extends StatefulWidget {

  const MenuBottomSheetOpened({super.key});

  @override
  State<MenuBottomSheetOpened> createState() => _MenuBottomSheetOpenedState();
}

class _MenuBottomSheetOpenedState extends State<MenuBottomSheetOpened>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: white,
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom + 54.0.h),
        child: Column(
          children: [
            customDivider(),
            customSheetAppBar(),
            SizedBox(height: 24.0.h),
            menuPagenation(),
            Flexible(child: pageView()),
          ],
        ),
      ),
    );
  }

  Widget customSheetAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      width: 390.0,
      height: 56.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40.0.w,
            height: 40.0.h,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon:
                  SvgPicture.asset('assets/icon/ico-line-arrow-back-black.svg'),
            ),
          ),
          Text('메뉴보기',
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

  List<String> categoryList = [];
  List<String> categoryListSortOrder = []; // 원하는 순서대로 리스트 생성

  // 파이어베이스 데이터
  Map<String, List<Menu>> menusByCategory = {};

  // 파이어베이스 데이터
  void _initializeData() async {
    try {
      final data = await FireStore.getMenusGroupedByCategory(UserProvider.of(context).currentStore.storeId);
      if (mounted) {
        setState(() {
          menusByCategory = data;
        });
      }
    } catch (error) {
      print('getMenuList() failed');
    }
    // 기존의 categories Set을 List로 변환하여 원하는 순서로 배열
    categoryList = menusByCategory.keys.toList();
    categoryListSortOrder = ['시그니처', '계절메뉴', '드립커피', '커피', '음료', '기타', '디저트', '굿즈']; // 원하는 순서대로 리스트 생성

    categoryList.sort((a, b) {
      var indexA = categoryListSortOrder.indexOf(a);
      var indexB = categoryListSortOrder.indexOf(b);

      // a와 b가 모두 customOrder에 존재하는 경우
      if (indexA != -1 && indexB != -1) {
        return indexA.compareTo(indexB);
      }
      // a가 customOrder에 존재하지 않지만 b는 존재하는 경우
      else if (indexA == -1 && indexB != -1) {
        return 1; // b가 a보다 앞에 올 수 있도록 1 반환
      }
      // a가 customOrder에 존재하지만 b는 존재하지 않는 경우
      else if (indexA != -1 && indexB == -1) {
        return -1; // a가 b보다 앞에 올 수 있도록 -1 반환
      }
      // a와 b 모두 customOrder에 존재하지 않는 경우
      else {
        return a.compareTo(b); // 문자열 비교 기준으로 정렬
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  int currentIndex = 0;
  late PageController _pageController;

  Widget menuPagenation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: List.generate(
            categoryList.length,
            (index) =>
                menuHorizonListButton(categoryList[index], () {
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

  Widget pageView() {
    UserProvider userProvider = context.read<UserProvider>();
    return SizedBox(
      height: 580.0,
      child: menusByCategory.isEmpty ? const Center(child: Text('! 메뉴 준비중', style: TextStyle(color: gray80),)) : PageView.builder(
        controller: _pageController,
        itemCount: categoryList.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final category = categoryList[index];
          final categoryMenus = menusByCategory[category];
          return ListView.builder(
            padding: EdgeInsets.only(top: 24.0.h),
            itemCount: categoryMenus!.length,
            itemBuilder: (context, index) {
              final coffeeItem = categoryMenus[index];
              return cudiMenu(
                context,
                goToMenu: () => userProvider.goMenuScreen(context, coffeeItem), menu: coffeeItem,
              );
            },
          );
        },
      ),
    );
  }
}
