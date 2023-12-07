import 'package:CUDI/screens/details/order_screen.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../utils/firebase_firestore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(
      {super.key});

  static double bottomStackHeight = 72.0 + 88.0;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late String userEmailId;
  late String storeId;
  String storeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                cudiAppTopSpace(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: cudiAppBar(context, appBarTitle: '장바구니'),
                ),
                cartList.length == 0
                    ? noContent(
                    context,
                    'assets/images/img-emptystate-cartlist.png',
                    178.0,
                    136.0,
                    '장바구니가 비어있어요!',
                    '좋아하는 카페 메뉴를 담아보세요',
                    '카페 둘러보기'
                )
                    :Column(
                  children: [
                    cartOfOnlyOneStore(),
                    const Divider(height: 1.0, color: Color(0xff3D3D3D)),
                    orderListViewBuilder(),
                  ],
                )
              ],
            ),
            cartList.length == 0? SizedBox() : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: CartScreen.bottomStackHeight,
                decoration: const BoxDecoration(
                  color: black,
                  border: Border(
                    top: BorderSide(
                      color: gray3D,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.h, vertical: 12.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('총',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700)),
                          priceText(
                              price: cartSumPrice,
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.0.h),
                      child: whiteButton('주문하기', null, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderScreen()));
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle orderSmall =
      const TextStyle(color: Color(0xffB5B5B6), fontSize: 12.0, height: 1.6);
  late List<Cart> cartList = [];
  late Map store = {};
  int cartSumPrice = 0;
  int menuQuantity = 0;

  void _initializeData() async {
    userEmailId = UserProvider.of(context).userEmailId;
    cartSumPrice = 0;
    menuQuantity = 0;
    late List<Cart> data;
    late DocumentSnapshot<Map<String, dynamic>> data2;
    if (mounted) {
      data = await FireStore.getCart(userEmailId);
    }
    setState(() {
      cartList = data;
      if (cartList.isNotEmpty) {
        storeId = cartList[0].storeId.toString();
      }
    });
    if (cartList.isNotEmpty) {
      data2 = await FireStore.db.collection('store').doc(storeId).get();
      setState(() {
        storeName = data2.data()?['store_name'];
      });
    }
    for (int i = 0; i < cartList.length; i++) {
      cartSumPrice += (cartList[i].menuSumPrice! * cartList[i].quantity!);
      menuQuantity += (cartList[i].quantity!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Widget cartOfOnlyOneStore(){
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(storeName, style: s16w500),
          SizedBox(
            height: 24.0.h,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_rounded)),
          ),
        ],
      ),
    );
  }

  Widget orderListViewBuilder() {
    return SizedBox(
      height: 580.0,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: CartScreen.bottomStackHeight),
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            return orderContainerOfCart(index);
          },
        ),
      ),
    );
  }

  Widget orderContainerOfCart(int index){
    return Container(
      height: 249.0.h + 24.0.h,
      decoration: const BoxDecoration(
          // color: Colors.white10,
          border: Border(bottom: BorderSide())),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          // color: Colors.white12,
          child: Row(
            children: [
              SizedBox(
                width: 104.0,
                child: Image.network(cartList[index].menuImgUrl.toString(),
                  fit: BoxFit.cover, // 이미지가 세로로 꽉 차도록 설정
                  height: double.infinity, // 이미지 위젯의 높이를 최대화
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(CartList[index].storeId.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (cartList[index].menuName != null)
                          Text(cartList[index].menuName.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 24.0.h,
                          width: 24.0.w,
                          child: IconButton(
                            onPressed: () {
                              // print(CartList[index].orderId);
                              FireStore.deleteCartDoc(
                                  cartList[index]
                                      .cartId
                                      .toString(), userEmailId);
                              _initializeData();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        )
                      ],
                    ),
                    Flexible(
                        flex: 50,
                        child: orderOptions(cartList[index])),
                    if (cartList[index].menuSumPrice != null)
                      priceText(
                          price: cartList[index].menuSumPrice!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500)),
                    const Spacer(flex: 5),
                    if (cartList[index].quantity != null)
                      Text('수량 ${cartList[index].quantity}개',
                          style: orderSmall),
                    const Spacer(flex: 3),
                    Row(
                      children: [
                        orderPlusMinusButton(
                            cartList[index].cartId.toString()),
                        SizedBox(width: 8.0.w),
                        orderOptionEditButton(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int addQuantity = 1;

  Widget orderPlusMinusButton(String orderId) {
    return Container(
      width: 96.0.w,
      height: 32.0.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: gray80)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (96.0.w - 16.0.w) / 2,
            child: TextButton(
              onPressed: () {
                FireStore.updateOrderQuantity(orderId, userEmailId, isPlus: false);
                _initializeData();
              },
              child: const Text('-',
                  style: TextStyle(color: grayEA, fontSize: 12.0)),
            ),
          ),
          SizedBox(
            child: Text(addQuantity.toString(),
                style: const TextStyle(color: grayEA, fontSize: 12.0)),
          ),
          SizedBox(
            width: (96.0.w - 16.0.w) / 2,
            child: TextButton(
              onPressed: () {
                FireStore.updateOrderQuantity(orderId, userEmailId);
                _initializeData();
              },
              child: const Text('+',
                  style: TextStyle(color: grayEA, fontSize: 12.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderOptions(Cart Cart) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: SizedBox(
        height: 95.0.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 컵
              Text(Cart.cup.toString(), style: orderSmall),
              // 핫 or 아이스
              if (Cart.selectedValue != null)
                Text(Cart.selectedValue.toString(), style: orderSmall),
              // 샷 추가
              if (Cart.addedShot != null)
                Text('샷추가(${(Cart.addedShot!*600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)', style: orderSmall),
              // 시럽 추가
              if (Cart.addedSyrup != null)
                Text('시럽추가(${(Cart.addedSyrup!*600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)', style: orderSmall),
              // 휘핑 추가 - 아직 없음
              if (Cart.addedWhipping != null)
                Text('휘핑추가(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)', style: orderSmall),
              // 다중 선택을 휘핑으로 뷰에서만
              if (Cart.selectedValue != null)
                Text('휘핑추가(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)', style: orderSmall),
              // 단일 선택
              if (Cart.selectedValue2 != null)
                Text('단일선택(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)', style: orderSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderOptionEditButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 74.0.w,
        height: 32.0.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: gray80)),
        alignment: Alignment.center,
        child: Text('옵션수정', style: TextStyle(color: grayEA, fontSize: 12.0.sp)),
      ),
    );
  }

  Future<void> _refresh() async {
    _initializeData();
  }
}
