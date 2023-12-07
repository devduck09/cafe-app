import 'package:CUDI/screens/details/my_cupay_screen.dart';
import 'package:CUDI/screens/details/near_screen.dart';
import 'package:CUDI/screens/details/push_screen.dart';
import 'package:CUDI/screens/details/view_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../utils/provider.dart';
import '../../widgets/main_stores.dart';
import '../../widgets/etc/cudi_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userEmailId;
  @override
  Widget build(BuildContext context) {
    userEmailId = Provider.of<UserProvider>(context).userEmailId;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    children: [
                      cudiAppTopSpace(),
                      profile(),
                      mainSaying(),
                      mainHorizonList(),
                      SizedBox(height: 32.h),
                      mainViewMoreTextButton(),
                      SizedBox(height: 16.h),
                      view(),
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

  Widget profile() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 12.h, 24.h, 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          circleBeany(isSmail: true, size: 56),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    opacity = 0.5; // 터치 다운 시 투명도 변경
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    opacity = 1.0; // 터치 업 시 투명도 원래대로 복원
                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const MyCupayScreen()));
                },
                onTapCancel: () {
                  setState(() {
                    opacity = 1.0; // 터치 취소 시 투명도 원래대로 복원
                  });
                },
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 100),
                  child: Image.asset(
                    'assets/icon/cupay.png',
                    width: 89.0,
                    height: 32.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
                height: 10.0,
              ),
              SizedBox(
                width: 24.0,
                height: 24.0,
                child: IconButton(
                    icon: Image.asset(
                      'assets/icon/bell_none.png',
                    ),
                    constraints: const BoxConstraints(), // 아이콘 패딩 제거
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      // showModalBottomSheet<void>(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   builder: (context) {
                      //     return const NotifBottomSheetOpened();
                      //   },
                      // );
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const PushScreen()));
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  double opacity = 1.0;
  String viewMoreText = viewMoreTitles[0];

  Widget mainSaying() {
    return bigText('비니님, 반가워요.\n궁금한 카페 3D로 구경해요!');
  }

  Widget mainHorizonList() {
    return SizedBox(
      height: 40.0.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            return cudiHorizonListButton(
                categoryItems[index].label, categoryItems[index].icon, () async {
              setState(() {
                for (int i = 0; i < categoryItems.length; i++) {
                  categoryItems[i].isSelected = (i == index);
                }
                viewMoreText = viewMoreTitles[index];
              });
              await CudiProvider.getAndSetStores(context, index: index);
              if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NearScreen(userEmailId: userEmailId)));
              }
            }, categoryItems[index].isSelected);
          }),
    );
  }

  Widget mainViewMoreTextButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoreScreen(title: viewMoreTitles[0]))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              viewMoreText,
              style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
                height: 1.0,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget view() {
    return MainStores(
        userEmailId: userEmailId, whatScreen: "home_horizon");
  }
}

class CategoryItem {
  late bool isSelected;
  final String label;
  final String icon;

  CategoryItem(this.isSelected, this.label, this.icon);
}

// 페이지뷰
List<CategoryItem> categoryItems = [
  CategoryItem(true, 'NEW', 'assets/icon/new.png'),
  CategoryItem(false, 'HOT', 'assets/icon/hot.png'),
  CategoryItem(false, 'NEAR', 'assets/icon/near.png'),
  CategoryItem(false, 'RECENT', 'assets/icon/recent.png'),
];

List<String> viewMoreTitles = ['쿠디 신규 입점', '쿠디 찜 많은 순', '가까운 카페', '최근 방문한 카페'];