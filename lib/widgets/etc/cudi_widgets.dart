import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/theme.dart';
import '../../models/menu.dart';
import '../../models/store.dart';
import '../sheets/menu_bottom_sheet_opend.dart';
import 'cudi_buttons.dart';

SliverAppBar sliverAppBar(BuildContext context,
    {String? title, Widget? iconButton, bool? isGoHome}) {
  return SliverAppBar(
    pinned: true,
    snap: true,
    floating: true,
    centerTitle: true,
    backgroundColor: black,
    surfaceTintColor: Colors.transparent,
    leadingWidth: 56.0 + 24.w,
    // default 56.0
    toolbarHeight: 88.h,
    leading: MaterialButton(
      shape: const CircleBorder(),
      height: 20.h,
      onPressed: () {
        isGoHome != null && isGoHome
            ? Navigator.pushNamedAndRemoveUntil(
                context, RouteName.home, (route) => false)
            : Navigator.pop(context);
      },
      child: SvgPicture.asset('assets/icon/ico-line-arrow-back-white.svg'),
    ),
    title: Text(title ?? '', style: appBarStyle),
    actions: [
      iconButton ?? const SizedBox(),
      SizedBox(width: 24.w)
    ],
  );
}

Widget cudiAppTopSpace() {
  return SizedBox(height: 16.h);
}

Widget cudiAppBar(BuildContext context,
    {String? appBarTitle,
    Widget? iconButton,
    bool? isGoToMain,
    bool? isPadding}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: isPadding != null ? 24.0 : 0),
    child: SizedBox(
      height: 56.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 20.0,
              height: 20.0,
              child: IconButton(
                  onPressed: () => isGoToMain != null
                      ? Navigator.pushReplacementNamed(context, RouteName.home)
                      : Navigator.pop(context),
                  icon: SvgPicture.asset(
                      'assets/icon/ico-line-arrow-back-white.svg'))),
          Text(appBarTitle ?? '',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
              width: 20.0,
              height: 20.0,
              child: iconButton ?? const SizedBox(width: 20.0)),
        ],
      ),
    ),
  );
}

Widget newBadge() {
  return Positioned(
    right: 0,
    top: 0,
    child: CircleAvatar(
      radius: 6.w,
      backgroundColor: heart,
      child: const Text('N',
          style: TextStyle(
              fontSize: 8.0, color: white, fontWeight: FontWeight.w900)),
    ),
  );
}

Widget circleBeany({required bool isSmail, required double size}) {
  return Image.asset(isSmail ? 'assets/images/img-profile-success-96px.png' : 'assets/images/img-profile-fail-96px.png', width: size, height: size);
}

Widget cudiMenu(
  BuildContext context, {
  // required String menuName,
  // required String menuDescription,
  // required int menuPrice,
  // required dynamic allergyList,
  // required VoidCallback goToMenu,
  // required List<String>? menuImgList,
  required Menu menu,
      required VoidCallback goToMenu,
}) {
  // String allergies = '알레르기: ${menu.allergyList}';
  bool isBest = false;
  return InkWell(
    onTap: goToMenu,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(24.0.w, 0, 24.0.w, 24.0.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xffEAEAEA), // 테두리의 색상 설정
                width: 1.0, // 테두리의 두께 설정
              ),
            ),
          ),
          child: SizedBox(
            height: 188.0.h + 5.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 104.0.w,
                  child: Image.network(
                    menu.menuImgList?[0] ?? '', // 유효하지 않은 URL일 경우의 처리
                    width: 104.0.w,
                    height: 184.0.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 104.0.w,
                        height: 184.0.h,
                        color: grayEA, // 에러 발생 시 대체할 색 또는 위젯 설정
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.0.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isBest ? cudiBest() : SizedBox(),
                    isBest ? SizedBox(height: 10.0.h) : SizedBox(),
                    SizedBox(
                      width: 222.0.w,
                      child: Text(
                        '${menu.menuName}',
                        style: s16w600.copyWith(color: black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: 200.0.w,
                      child: Text(
                        '${menu.menuDesc}',
                        style: TextStyle(
                            color: gray58, fontSize: 12.0, height: 1.6.h),
                        maxLines: 2,
                        // 원하는 최대 줄 수를 설정
                        overflow: TextOverflow.ellipsis,
                        // 일정 너비 이상의 텍스트는 '...'으로 줄임
                        softWrap: true, // 텍스트가 너비를 넘어갈 때 자동으로 줄 바꿈을 활성화
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      '${menu.menuPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.0.h),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icon/ico-line-notice.svg'),
                        SizedBox(
                          width: 4.0.w,
                        ),
                        SizedBox(
                            width: 180.0.w,
                            child: Text('${menu.menuAllergy}',
                                style: const TextStyle(
                                    color: gray58, fontSize: 12.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)),
                        // Text(' 알레르기: '+ (for (int i = 0; i < allergyList.length; i++) allergyList[i] +', ')),
                        // ' 알레르기: '
                        // '${allergyList[0]}, ${allergyList[1]}, ${allergyList[2]}',
                        // style: TextStyle(color: gray58, fontSize: 12.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24.0)
      ],
    ),
  );
}

Widget cudiBest() {
  return Container(
    width: 81.0,
    height: 20.0,
    color: black,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text('CUDI BEST',
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w600, inherit: false),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    ),
  );
}

Widget customDivider() {
  return Padding(
    padding: EdgeInsets.all(16.0.h),
    child: Container(
      width: 32.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: const Color(0xffA8A8A8),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    // child: const Divider(thickness: 4.0, color: Color(0xffA8A8A8)),
  );
}

Widget priceText({required int price, required TextStyle style}) {
  return Text(
    '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
    style: style,
  );
}

Widget menuInfo(
    BuildContext context,
    // String manuName,
    // String manuDescription,
    // int menuPrice,
    // String menuAllergy,
    // int? dripSweet,
    // int? dripBitter,
    // int? dripSour,
    // int? dripBody
    ) {
  Menu menu = UserProvider.of(context).currentMenu;
  bool drip = false;
  if (menu.dripSweet == null) {
    drip = false;
  } else {
    drip = true;
  }

  List dripTaste = ['단맛', '쓴맛', '신맛', '바디'];
  List dripTasteNum = [menu.dripSweet, menu.dripBitter, menu.dripSour, menu.dripBody];

  dynamic five = 5;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 8.0.h),
      // cudiBest(),
      SizedBox(height: 16.0.h),
      Text('${menu.menuName}',
          style: TextStyle(
              color: black,
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w600,
              height: 1)),
      SizedBox(height: 8.0.h),
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
              style:
                  TextStyle(fontSize: 14.0.sp, color: gray58, height: 1.7.h),
              menu.menuDesc != null && menu.menuDesc!.length > 90
                  ? '${menu.menuDesc?.substring(0, 90)}'
                  : menu.menuDesc ?? '')),
      SizedBox(height: drip ? 4.0.h : 12.0.h),
      drip
          ? SizedBox(
              height: 50,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dripTaste.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 8 / 1,
                ),
                itemBuilder: (BuildContext context, dripTasteIdx) {
                  return Row(
                    children: [
                      Text(
                        dripTaste[dripTasteIdx],
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: gray58,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 10 * 13.0.h,
                        height: 10,
                        child: Row(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: dripTasteNum[dripTasteIdx],
                                itemBuilder:
                                    (BuildContext context, tasteNumIdx) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: (Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                        color: gray3D,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    )),
                                  );
                                }),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: five - dripTasteNum[dripTasteIdx],
                              itemBuilder: (BuildContext context, idx) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: (Container(
                                    width: 10.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: gray58, width: 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          : SizedBox(),
      Text(
        '${menu.menuPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
        style: s16w500.copyWith(color: black),
      ),
      SizedBox(height: 16.0.h),
      Row(
        children: [
          SvgPicture.asset('assets/icon/ico-line-notice.svg'),
          const SizedBox(
            width: 4.0,
          ),
          Text(' 알레르기: ${menu.menuAllergy}',
              style: const TextStyle(color: gray58, fontSize: 12.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
      SizedBox(height: 24.0.h),
    ],
  );
}

Widget cudiDetailListItem(String title, String desc,
    {VoidCallback? click, Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: cudiCafeDetailDescTit,
        textAlign: TextAlign.start,
      ),
      SizedBox(
        height: 8.0.h,
      ),
      InkWell(
        onTap: click,
        child: Text(
          desc == '' ? '-' : desc,
          style: desc == ''
              ? cudiCafeDetailDesc
              : cudiCafeDetailDesc.copyWith(color: color),
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        height: 24.0.h,
      )
    ],
  );
}

Widget cupayCard() {
  return Container(
    // width: MediaQuery.of(context).size.width,
    height: 199.0.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/cudi_card.png'))),
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUDIPAY',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900)),
                  Text('0000 0000 0000 0000',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700)),
                ],
              ),
              Image.asset(
                'assets/icon/money.png',
                width: 32.0,
                height: 32.0,
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('잔액'),
                    Text('150,000원',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(
                  width: 28.0,
                  child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          'assets/icon/ico-line-charge-default-28px.svg')),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget containerTitle(BuildContext context,
    {required String text, required Widget where}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => where));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
          SvgPicture.asset('assets/icon/ico-line-arrow-right-white-24px.svg'),
        ],
      ),
    ),
  );
}

Widget cupayReserves({EdgeInsets? padding}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(top: 24.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: gray1C,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('사용 가능 적립금', style: w500),
              SizedBox(height: 12.h),
              priceText(price: 5600, style: s16w600),
            ],
          ),
          Image.asset(
            'assets/images/img-point.png',
            width: 48.w,
            height: 48.h,
          )
        ],
      ),
    ),
  );
}
//
// class FavoriteIcon extends StatefulWidget {
//   final bool isFavorite;
//   final Store store;
//   final String userEmailId;
//   final Function refreshData;
//
//   const FavoriteIcon(
//       {Key? key,
//       required this.isFavorite,
//       required this.store,
//       required this.userEmailId,
//       required this.refreshData})
//       : super(key: key);
//
//   @override
//   State<FavoriteIcon> createState() => _FavoriteIconState();
// }
//
// class _FavoriteIconState extends State<FavoriteIcon> {
//   @override
//   Widget build(BuildContext context) {
//     bool isFavorite = widget.isFavorite;
//     Store store = widget.store;
//     return Positioned(
//       right: 8.0,
//       bottom: 48.0,
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             isFavorite = !isFavorite;
//           });
//           if (isFavorite) {
//             FireStore.updateFavorite(widget.userEmailId, store.storeId, '',
//                 Timestamp.fromDate(DateTime.now()));
//             NotificationService()
//                 .showNotification('로컬 푸시 알림 🔔', '❤️ 찜한 카페에 추가되었습니다.');
//           } else {
//             FireStore.removeFavorite(widget.userEmailId, store.storeId);
//             NotificationService()
//                 .showNotification('로컬 푸시 알림 🔔', '찜한 카페에서 제거되었습니다.');
//           }
//           // _initializeData();
//           widget.refreshData;
//         },
//         child: SizedBox(
//           width: 32.0,
//           height: 32.0,
//           child: Image.asset(
//               isFavorite ? 'assets/icon/heart.png' : 'assets/icon/heart_o.png'),
//         ),
//       ),
//     );
//   }

Widget threeDIcon(Store store, BuildContext context) {
  return Positioned(
    bottom: 8.0,
    right: 8.0,
    child: SizedBox(
      width: 32.0,
      height: 32.0,
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, "/web_view",
            arguments: {"threeDUrl": store.storeThreeDUrl.toString()}),
        icon: Image.asset('assets/icon/view_3d.png'),
        constraints: const BoxConstraints(), // 아이콘 패딩 제거
        padding: const EdgeInsets.all(0),
      ),
    ),
  );
}

Widget customStoreAddress(String? address) {
  return SizedBox(
    width: 272.0,
    child: Text(
      getSimplifiedAddress(address.toString()).toString(),
      maxLines: 1,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.71429,
        overflow: TextOverflow.ellipsis,
        shadows: [
          Shadow(
            color: Colors.black, // 그림자 색상
            offset: Offset(2.0, 2.0), // 그림자 위치 (가로, 세로)
            blurRadius: 3.0, // 그림자 흐림 정도
          ),
        ],
      ),
    ),
  );
}

String? getSimplifiedAddress(String fullAddress) {
  RegExp regExp = RegExp(r'(\S+?[시|도])\s*(\S+?[구|군])');

  Match? match = regExp.firstMatch(fullAddress);

  return "${match?.group(1) ?? ""} ${match?.group(2) ?? ""}" == " "
      ? "주소를 찾을 수 없습니다."
      : "${match?.group(1)} ${match?.group(2)}";
}

Widget menuButtons(Store store, BuildContext context) {
  return Container(
    height: 72.0.h,
    color: black,
    child: Padding(
      padding: EdgeInsets.fromLTRB(24.0, 16.0.h, 24.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: whiteButton(
                  '3D투어',
                  'assets/icon/ico-line-3d-black.png',
                  () => Navigator.pushNamed(context, "/web_view", arguments: {
                        "threeDUrl": store.storeThreeDUrl.toString()
                      }))),
          const SizedBox(width: 20.0),
          Flexible(
            flex: 1,
            child: whiteButton('메뉴보기', 'assets/icon/ico-line-menu.png', () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                builder: (context) {
                  return const MenuBottomSheetOpened();
                },
              );
            }),
          ),
        ],
      ),
    ),
  );
}

Widget shareIcon() {
  void _shareFunction() {
    Share.share('https://cudi.page.link/viewcafe');
  }

  return SizedBox(
      width: 24.0.w,
      height: 24.0.h,
      child: IconButton(
          onPressed: () => _shareFunction(),
          icon: SvgPicture.asset('assets/icon/ico-line-share.svg')));
}

Widget noContent(BuildContext context, String imgUrl,double? imgWidth, double? imgHeight, String title, String subTitle, String btnText){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 114.0.h,),
        Container(height: 160.0,
            alignment: const Alignment(0.0, 1.0),
            child: Image.asset(imgUrl, width: imgWidth, height: imgHeight,)),
        SizedBox(height: 32.h,),
        Text(title, style: s16w600.copyWith(height: 1),),
        SizedBox(height: 12.h,),
        Text(subTitle, style: const TextStyle(height: 1.71, color: grayB5),),
        SizedBox(height: 32.h,),
        Container(
          width: 390.w,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
                  child: Text(btnText, style: s16w700.copyWith(height: 1),),
                )
            )
        ),
      ],
    ),
  );
}

Container noticeContainer(List<String> noticesTextList) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: grayF6
    ),
    child: ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: noticesTextList.length,
      itemBuilder: (context, index) {
      return Text(noticesTextList[index], style: noticeContainerText);
    },)
  );
}

Widget bulletText({required String text, required String bullet}) {
  var style = h19.copyWith(fontSize: 12.sp, color: gray79);
  return Padding(
    padding: EdgeInsets.only(left: 16.w), // 들여쓰기 크기 조절
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(bullet, style: style),
        SizedBox(width: 8.w), // 불릿과 텍스트 간격 조절
        Expanded(
          child: Text(
            text,
            style: style,
          ),
        ),
      ],
    ),
  );
}

Widget bigText(String text) {
  return Padding(
    padding: pd16v,
    child: Container(
      alignment: Alignment.centerLeft,
        child: Text(text, style: big, textAlign: TextAlign.start)),
  );
}