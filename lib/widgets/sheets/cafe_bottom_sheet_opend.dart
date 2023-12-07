import 'package:CUDI/config/theme.dart';
import 'package:CUDI/models/store.dart';
import 'package:CUDI/utils/notification_service.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:CUDI/widgets/haert_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/favorite_provider.dart';
import '../etc/cudi_buttons.dart';
import 'menu_bottom_sheet_opend.dart';

class CafeBottomSheetOpend extends StatefulWidget {
  final Store store;
  final String? userEmailId;
  const CafeBottomSheetOpend({super.key, required this.store, this.userEmailId});

  @override
  State<CafeBottomSheetOpend> createState() => _CafeBottomSheetOpendState();
}

class _CafeBottomSheetOpendState extends State<CafeBottomSheetOpend> {

  @override
  Widget build(BuildContext context) {
    Store store = widget.store;
    // 프로바이더
    // final favoriteStoresProvider = Provider.of<FavoriteStoresProvider>(context);
    // favoriteStoresProvider.fetchData(widget.userEmailId!);
    // bool isFavorite = favoriteStoresProvider.favoriteStores.containsKey(store.storeId);

    // safearea와 시안의 여백을 뺀 값
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + 54.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + 54.0.h + 72.h),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customDivider(),
                  customSheetAppBar(store),
                  SizedBox(height: 16.0.h),
                  storeDescription(store),
                  SizedBox(height: 24.0.h),
                  storeTagList(),
                  SizedBox(height: 24.0.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Divider(height: 1.0),
                  ),
                  Flexible(flex:1,child: storeInformation(store)),
                  storeBottomButton(),
                ],
              ),
            ),
            menuButtons(store, context),
          ],
        ),
      ),
    );
  }

  List<String> storeTag = ['직접 로스팅', '노키즈존', '루프탑', '내부 흡연실', '야경맛집'];
  int storeDescMaxLength = 200;

  Widget customSheetAppBar(Store store) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon:SvgPicture.asset('assets/icon/ico-line-arrow-back-black.svg'),
              ),
            ),
            Column(children: [
              Text(store.storeName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 8.0),
              Text(
                store.storeSubTitle!,
                style: TextStyle(color: gray58, fontSize: 14.sp),
              )
            ]),
            SizedBox(width: 40.0.w)
          ],
        ),
      ]),
    );
  }

  Widget storeDescription(Store store) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        // size?.height,
        store.storeDescription!.length <= storeDescMaxLength
            ? store.storeDescription!
            : '${store.storeDescription!.substring(0, storeDescMaxLength)}...',
        // 글자 수를 제한하고 넘치면 "..."을 추가
        style: TextStyle(
            fontSize: 13.0, color: const Color(0xff585856), height: 1.6.sp),
        softWrap: true,
        // overflow: TextOverflow.ellipsis
      ),
    );
  }

  Widget storeTagList() {
    return Container(
      padding: const EdgeInsets.only(left: 24.0),
      height: 32.0.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: storeTag.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 9.0.h),
                    elevation: 0.0,
                    disabledBackgroundColor: black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '#' + storeTag[index],
                    style: TextStyle(
                        fontSize: 12.0, color: white, height: 1.0),
                  )),
            );
          }),
    );
  }

  Widget storeInformation(Store store) {
    return SingleChildScrollView(
      child: SizedBox(
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(24.0, 24.h, 24.0, 0),
            itemCount: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cudiDetailListItem('영업시간', store.storeHours.toString()),
                  cudiDetailListItem('휴무일', store.storeClosed.toString(), color: heart),
                  cudiDetailListItem('주소지', store.storeAddress!, click: () => _launchInBrowser(Uri.parse(store.storeTMap!)), color: const Color(0xff6280E3)),
                  cudiDetailListItem('상세 주소', store.storeTraffic.toString()),
                  cudiDetailListItem('전화번호', store.storeTell!, click: () => _makePhoneCall(store.storeTell!), color: const Color(0xff6280E3)),
                  cudiDetailListItem('주차 가능', store.storeParking.toString()),
                ],
              );
            }),
      ),
    );
  }

  Widget storeBottomButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.0),
      decoration: const BoxDecoration(
        // color:Colors.purple,
          border:
          Border(top: BorderSide(color: Color(0xffEAEAEA), width: 1.0))),
      child: Row(
        children: [
          HeartIcon(storeId: widget.store.storeId, isPlain: true),
          const SizedBox(width: 32.0),
          shareIcon(),
        ],
      ),
    );
  }

  // 공유
  void _shareFunction() {
    Share.share('https://cudi.page.link/viewcafe');
  }

  // 브라우저 열기
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // 전화 걸기
  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } catch (e) {
      print(e);
    }
  }
}