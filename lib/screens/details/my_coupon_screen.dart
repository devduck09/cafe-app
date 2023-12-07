import 'package:CUDI/models/coupon.dart';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/theme.dart';
import '../../widgets/etc/cudi_widgets.dart';

class MyCouponScreen extends StatefulWidget {
  final String title;

  const MyCouponScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyCouponScreen> createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  List<String> tabBarTitles = ['전체', '사용가능', '사용완료'];

  List<Coupon> myCoupons = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    late List<Coupon> data;
    if (mounted) {
      data = await FireStore.getCoupons();
      setState(() {
        myCoupons = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSliverAppBar(context),
            _buildSliverList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return sliverAppBar(context, title: widget.title);
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(addRepaintBoundaries: true, [
        DefaultTabController(
          length: tabBarTitles.length,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - (91.h + 83.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tabBar(),
                tabBarView(),
                bottoms(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget tabBar() {
    return TabBar(
      labelStyle: s16w500,
      unselectedLabelColor: white,
      dividerColor: gray80,
      labelPadding: const EdgeInsets.all(16.0),
      indicatorWeight: 1.0,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      tabs: tabBarTitles.map((e) => Text(e)).toList(),
    );
  }

  Widget tabBarView() {
    final filteredCouponsA =
        myCoupons.where((item) => item.state == tabBarTitles[1]).toList();
    final filteredCouponsNA =
        myCoupons.where((item) => item.state == tabBarTitles[2]).toList();

    List<Widget> tabBarViewWidgets = [
      _buildCouponListView(myCoupons, '쿠폰이 없습니다.'),
      _buildCouponListView(filteredCouponsA, '사용 가능한 쿠폰이 없습니다.'),
      _buildCouponListView(filteredCouponsNA, '사용 완료한 쿠폰이 없습니다.'),
    ];

    return Expanded(
      child: TabBarView(
        children: tabBarViewWidgets,
      ),
    );
  }

  Widget _buildCouponListView(List<Coupon> coupons, String emptyMessage) {
    return coupons.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 24.0.h),
            itemCount: coupons.length,
            itemBuilder: (BuildContext context, int index) {
              return couponItem(coupons[index]);
            },
          )
        : Center(child: Text(emptyMessage));
  }

  TextStyle couponTitleSt =
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.42);

  Widget couponItem(Coupon coupon) {
    String discountRateText = '${coupon.discountRate}% 할인';
    String discountPriceText =
        '${coupon.discountPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원 할인';
    return Padding(
      padding: EdgeInsets.fromLTRB(24.h, 0, 24.h, 24.h),
      child: Container(
        height: 166.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/coupon.png'),
                fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    badge(coupon.state.toString()),
                    const Spacer(flex: 2),
                    Text(
                        coupon.discountRate != null
                            ? discountRateText
                            : discountPriceText,
                        style: couponTitleSt),
                    const Spacer(flex: 1),
                    Text('OOU 카페', style: w500),
                    Text(
                      '사용기한: ${coupon.finishDate?.year}년 ${coupon.finishDate?.month}월 ${coupon.finishDate?.day}일까지',
                      style: s12.copyWith(color: gray79),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => snackBar(context, '쿠폰이 발급되었습니다.'),
              child: Padding(
                padding: EdgeInsets.only(right: 24.w, top: 8.h, bottom: 8.h),
                child: SvgPicture.asset('assets/images/img-cooking.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget badge(String text) {
    return Container(
      width: 58.w,
      height: 20.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: text == "사용가능" ? const Color(0xff4AD097) : gray3D,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(text, style: s12w600),
    );
  }

  Widget bottoms() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
          children: [
        notice(),
        whiteButton('쿠폰 모두 다운받기', null, () {})
      ]),
    );
  }

  Widget notice() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        width: double.infinity, // 가로로 확장되도록 추가
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: gray1C,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '∙ 지급된 쿠폰은 앱에서만 사용이 가능합니다.',
          style: s12.copyWith(color: gray79, height: 1.9),
        ),
      ),
    );
  }
}
