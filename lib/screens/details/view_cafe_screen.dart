import 'package:CUDI/widgets/haert_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/store.dart';
import '../../utils/provider.dart';
import '../../widgets/sheets/cafe_bottom_sheet_opend.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../../widgets/video_player.dart';

class ViewCafeScreen extends StatefulWidget {

  const ViewCafeScreen({Key? key}) : super(key: key);

  @override
  State<ViewCafeScreen> createState() => _ViewCafeScreenState();
}

class _ViewCafeScreenState extends State<ViewCafeScreen> {
  // state 레벨 변수
  late String userEmailId;
  late CudiProvider provider;
  late Store store;
  int currentIndex = 0;
  late PageController _pageController;
  late bool isView;

  @override
  Widget build(BuildContext context) {
    store = UserProvider.of(context).currentStore;
    provider = Provider.of<CudiProvider>(context);
    userEmailId = Provider.of<UserProvider>(context).userEmailId;
    isView = provider.isView;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            storeMedia(),
            if(!isView) gradient(),
            if(!isView) blackCover(),
            if(!isView) Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tops(),
                bottoms(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget storeMedia() {
    return InkWell(
      onTap: () => provider.setView(isView),
      child: ClipRRect(
        // 배경 슬라이드
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        child: SizedBox(
          child: PageView.builder(
            controller: _pageController,
            itemCount: store.storeImgList?.length ?? 0,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                // 첫 번째 페이지에 비디오 플레이어를 표시
                return VideoApp(
                    videoUrl: store.storeVideoUrl.toString(),
                    thumbnailUrl: store.storeThumbnail.toString());
              } else {
                // 나머지 페이지에 Container를 표시
                // int adjustedIndex = index - 1; // 첫 번째 페이지를 뺀 나머지 페이지의 인덱스
                return store.storeImgList?[index] != ''
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(store.storeImgList?[index] ?? ''),
                                fit: BoxFit.cover)))
                    : const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget gradient() {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.28), // 연하게
              Colors.transparent,
            ],
            stops: [0.0, 0.25], // 11/20 수정됨 // 짧게
          ),
        ),
      ),
    );
  }

  Widget blackCover() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(height: 150.0, color: black));
  }

  Widget tops() {
    return Column(
      children: [
        SizedBox(height: 54.0.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: cudiAppBar(context),
        ),
      ],
    );
  }

  Widget bottoms() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // TextButton(onPressed: () {
        //   FireStore.updateStoreData(store.storeId!, 35.162297, 129.160803);
        // }, child: const Text('함수 실행')),
        // TextButton(onPressed: (){
        //
        //   Menu one = Menu(
        //     storeId: store.storeId,
        //     menuName: '황치즈버터바',
        //     menuPrice: 3200,
        //     menuDesc: '쫀득한 식감과 황치즈와 향 그리고 단짠단짠한 맛을 느낄수있는 황치즈 버터바입니다.',
        //     menuImgList: [
        //       'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/menu/cheese_butterbar.jpg'
        //     ],
        //     menuAllergy: '밀, 계란, 우유, 대두',
        //     menuCategory: '시그니처',
        //   );
        //
        //   Menu two = Menu(
        //     storeId: store.storeId,
        //     menuName: '흑임자 휘낭시에',
        //     menuPrice: 3000,
        //     menuDesc: '흑임자 베이스의 휘낭쉬에',
        //     menuImgList: [
        //       'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/menu/black_financier.jpg'
        //     ],
        //     menuAllergy: '밀, 계란, 우유, 대두',
        //     menuCategory: '디저트',
        //   );
        //
        //   Menu three = Menu(
        //     storeId: store.storeId,
        //     menuName: '카페라떼',
        //     menuPrice: 5000,
        //     menuDesc: '내나 있다입니꺼..그 우리가 흔히 아는 그 라떼 입니다. 다만 에스프레소에 집중하는 업체인 만큼 맛이 대한 자신은 있습니다.',
        //     menuImgList: [
        //       'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/menu/cafelatte_ice.jpg',
        //       'https://3d-allrounder.com/allrounder-modules/app_img/hs_standard/menu/cafelatte_hot.jpg'
        //     ],
        //     menuAllergy: '우유',
        //     menuCategory: '커피',
        //   );
        //
        //   List<Menu> etcMenuListFinalPart = [
        //     one,
        //     two,
        //     three
        //   ];
        //
        //   for (Menu eachMenu in etcMenuListFinalPart) {
        //     FireStore.addMenu(eachMenu, store.storeId);
        //   }
        // }, child: const Text('이 스토어의 메뉴 추가')),
        menuPagenation(store),
        manuBottomSheetClosed(store),
        menuButtons(store, context),
      ],
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget menuPagenation(Store store) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // 오른쪽으로 스와이프
          if (currentIndex < (store.storeImgList?.length ?? 0)) {
            setState(() {
              currentIndex++;
            });
            _pageController.jumpToPage(currentIndex);
          }
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // 왼쪽으로 스와이프
          if (currentIndex > 0) {
            setState(() {
              currentIndex--;
            });
            _pageController.jumpToPage(currentIndex);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Container(
          width: ((store.storeImgList?.length ?? 0) - 1) * 16.0 + 20.0 + 16.0,
          // 불릿(8), 가로 패딩(8) + 양쪽 여백 (20) + 비디오 페이지 포함 (16.0)
          height: 24.0,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                store.storeImgList?.length ?? 0,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                      _pageController.jumpToPage(currentIndex);
                    },
                    child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color:
                                index == currentIndex ? white : Colors.white24,
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget manuBottomSheetClosed(Store store) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: black,
          builder: (context) {
            return CafeBottomSheetOpend(
              store: store,
              userEmailId: userEmailId,
            );
          },
        );
      },
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -20.0) {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: black,
            builder: (context) {
              return CafeBottomSheetOpend(
                store: store,
                userEmailId: userEmailId,
              );
            },
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0))),
        child: Column(
          children: [
            customDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.storeName.toString(),
                      style: TextStyle(
                          color: black,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w600)),
                  Text(store.storeAddress.toString(),
                      style: const TextStyle(color: gray58),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 24.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeartIcon(storeId: store.storeId, isPlain: true),
                      const SizedBox(width: 32.0),
                      shareIcon(),
                    ],
                  ),
                  SizedBox(height: 24.0.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
