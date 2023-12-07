import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/utils/secure_shot.dart';
import 'package:CUDI/widgets/closed_sheet.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../utils/firebase_firestore.dart';
import '../../utils/provider.dart';
import '../../widgets/cart_icons.dart';
import '../../widgets/etc/cudi_buttons.dart';
import '../../widgets/etc/cudi_widgets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String userEmailId;
  late Menu menu;
  late Cart cart;
  int currentIndex = 0;
  late PageController _pageController;
  bool isView = false;

  @override
  void initState() {
    super.initState();
    userEmailId = UserProvider.of(context).userEmailId;
    menu = UserProvider.of(context).currentMenu;
    cart = Cart(
      userEmailId: userEmailId,
      storeId: menu.storeId,
      menuId: menu.menuId,
      menuName: menu.menuName,
      menuImgUrl: menu.menuImgList?[0],
      menuSumPrice: menu.menuPrice,
      quantity: 1,
      cup: "매장컵",
    );
    SecureShot.on();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    SecureShot.off();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            menuImage(),
            stacks(),
          ],
        ),
      ),
    );
  }

  Widget menuImage() {
    double mh = MediaQuery.of(context).size.height;
    double mpb = MediaQuery.of(context).padding.bottom;
    double imageHeight = isView ? mh - mpb : 580.h;
    double mw = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        setState(() => isView = !isView);
      },
      child: SizedBox(
        height: imageHeight,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: _pageController,
          itemCount: menu.menuImgList?.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              menu.menuImgList?[index] ?? '',
              width: mw,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 515.0.h,
                  color: grayEA,
                  child: const Center(
                      child: Text(
                    '이미지 준비중',
                    style: TextStyle(color: gray58),
                  )), // 에러 발생 시 대체할 색 또는 위젯 설정
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget stacks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        top(),
        bottoms(),
      ],
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 16.0),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: cudiAppBar(context, iconButton: const CartIcon()),
      ),
    );
  }

  Widget bottoms() {
    return isView
        ? const SizedBox(
            width: 0,
          )
        : Column(
            children: [
              const ClosedSheet(),
              orderButtons(),
              // SizedBox(height: 21.0,)
            ],
          );
  }

  int count = 0;
  String cartId ='';

  Widget orderButtons() {
    return Container(
      height: 72.0.h,
      color: black,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.0, 16.0.h, 24.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: whiteButton(
                    '메뉴담기',
                    'assets/icon/ico-line-cart.png',
                    () async {
                      if (count >= 1) {
                        FireStore.updateOrderQuantity(cartId, userEmailId);
                        snackBar(context, '수량이 추가되었습니다.', label: '보러가기', click:() => Navigator.pushNamed(context, RouteName.cart));
                      } else {
                        cartId = await UserProvider.addToCart(context, cart);
                        count ++;
                      }
                    })),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 1,
              child: whiteButton('바로결제', 'assets/icon/ico-line-pay.png', () {
                FireStore.addCart(context, cart);
                Navigator.pushNamed(context, RouteName.order);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
