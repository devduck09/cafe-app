import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/theme.dart';
import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../utils/provider.dart';
import '../etc/cudi_buttons.dart';
import '../etc/cudi_checkboxes.dart';
import '../etc/cudi_util_widgets.dart';
import '../etc/cudi_widgets.dart';

class OrderBottomSheetOpened extends StatefulWidget {
  const OrderBottomSheetOpened({super.key});

  @override
  State<OrderBottomSheetOpened> createState() => _OrderBottomSheetOpenedState();
}

class _OrderBottomSheetOpenedState extends State<OrderBottomSheetOpened> {
  late String userEmailId;
  late Menu menu;
  late Cart cart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.bottom + 54.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.bottom + 54.0.h + 72.0.h),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  customDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      // height: 575.0.h,
                      // height: 588.h,
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).padding.bottom +
                              54.0.h +
                              72.0.h +
                              32.0.h +
                              4.0 +
                              73.0),
                      child: ListView(
                        children: [
                          menuInfo(context), // 메뉴 인포
                          orderSelectHotOrIced(), // 핫 아이스 선택
                          SizedBox(height: 24.0.h),
                          const Divider(color: Color(0xffEAEAEA), height: 1.0),
                          orderSelectList(), // 옵션들
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Color(0xffEAEAEA), height: 1.0),
                  sumPriceWidget(),
                ],
              ),
            ),
            Column(
              children: [
                orderButtonsTwice(userEmailId),
                //Container(height: 21.0, color: black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Cart cart = Cart();
  // late int sumPrice;
  List<String> cup = ['매장컵', '일회용컵'];
  List<bool> isSelected = [true, false];
  int shotCount = 0;
  int syrupCount = 0;

  @override
  void initState() {
    super.initState();
    userEmailId = UserProvider().userEmailId;
    menu = UserProvider().currentMenu;
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
  }

  Widget orderSelectHotOrIced() {
    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: orderHotOrIcedButton(cup[0], () {
              // 버튼을 클릭하면 isSelected 값을 변경합니다.
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = (i == 0);
                  cart.cup = cup[0];
                }
              });
            }, isSelected[0]),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: orderHotOrIcedButton(cup[1], () {
              // 버튼을 클릭하면 isSelected 값을 변경합니다.
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = (i == 1);
                  cart.cup = cup[1];
                }
              });
            }, isSelected[1]),
          ),
        ],
      ),
    );
  }

  Widget orderSelectAdd(
      {required String what,
      required int addPrice,
      required VoidCallback plus,
      required VoidCallback minus,
      required int count}) {
    return Container(
      height: 65.0,
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(what,
                  style: const TextStyle(
                      color: black, fontWeight: FontWeight.w500)),
              priceText(
                  price: addPrice,
                  style: const TextStyle(
                      color: gray58, fontSize: 12.0, height: 1.6)),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            width: 120.0,
            height: 36.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: grayEA)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: ElevatedButton(
                      onPressed: minus,
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(
                          'assets/icon/ico-line-count-down.svg')),
                ),
                SizedBox(
                  width: 20.0,
                  child: Text(
                    count.toString(),
                    style: const TextStyle(color: gray58),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: ElevatedButton(
                      onPressed: plus,
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(
                          'assets/icon/ico-line-count-plus.svg')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderSelectCheck() {
    return Container(
      height: 65.0,
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('옵션 유형2(다중선택)',
                  style: TextStyle(color: black, fontWeight: FontWeight.w500)),
              Text('600원',
                  style: TextStyle(color: gray58, fontSize: 12.0, height: 1.6)),
            ],
          ),
          cudiWhiteFillCheckBox(
              cart.isChecked ?? false,
              (bool? value) => setState(() {
                    cart.isChecked = value ?? false;
                    if (value!) {
                      cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                    } else {
                      cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                    }
                  })),
        ],
      ),
    );
  }

  Widget orderSelectRadio(String? value, int price, int groupValueNumber) {
    return Container(
      height: 65.0,
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value!,
                  style: const TextStyle(
                      color: black, fontWeight: FontWeight.w500)),
              Text('$price원',
                  style: const TextStyle(
                      color: gray58, fontSize: 12.0, height: 1.6)),
            ],
          ),
          Radio(
            value: value,
            toggleable: groupValueNumber == 1 ? false : true,
            groupValue: groupValueNumber == 1
                ? cart.selectedValue
                : cart.selectedValue2,
            onChanged: (selectedValue) {
              setState(() {
                if (groupValueNumber == 1) {
                  cart.selectedValue = selectedValue;
                } else if (groupValueNumber == 2) {
                  cart.selectedValue2 = selectedValue;
                  if (selectedValue == null) {
                    cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                  } else {
                    cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                  }
                }
              });
              print(cart.selectedValue);
              print(cart.selectedValue2);
            },
            fillColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return primary.withOpacity(0.82); // Custom disabled color
              }
              return grayEA; // Custom enabled color
            }),
          ),
        ],
      ),
    );
  }

  Widget orderSelectList() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w, vertical: 12.0.h),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: const Color(0xffF6F6F7),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Text(
                        '・ 좌석이 없을시 일회용컵으로 대체 가능합니다. \n・ 개인컵 사용시 직원에게 전달해 주세요. \n・ 매장마다 운영 상황이 다를 수 있습니다. \n・ 여기 문구는 관리자에서 입력이 가능합니다.',
                        style: TextStyle(
                            color: gray80, fontSize: 12.0, height: 1.6)),
                  ),
                ),
                orderSelectRadio('HOT', 0, 1),
                orderSelectRadio('ICED', 0, 1),
                orderSelectRadio('ICED ONLY', 0, 1),
                orderSelectAdd(
                  what: '샷추가',
                  addPrice: 600,
                  plus: () {
                    setState(() {
                      if (shotCount < 10) {
                        shotCount++;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '한 메뉴에 10개 이상을 선택할 수 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        )));
                      }
                    });
                  },
                  minus: () {
                    setState(() {
                      if (shotCount > 0) {
                        shotCount--;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                      }
                    });
                  },
                  count: shotCount,
                ),
                orderSelectAdd(
                  // storeMenuOne: storeMenuOne,
                  what: '시럽추가',
                  addPrice: 600,
                  plus: () {
                    setState(() {
                      if (syrupCount < 10) {
                        syrupCount++;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '한 메뉴에 10개 이상을 선택할 수 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        )));
                      }
                    });
                  },
                  minus: () {
                    setState(() {
                      if (syrupCount > 0) {
                        syrupCount--;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                      }
                    });
                  },
                  count: syrupCount,
                ),
                orderSelectCheck(),
                orderSelectRadio('옵션 유형2(단일선택)', 600, 2),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Container(
              alignment: Alignment.center,
              height: 36.0,
              decoration: BoxDecoration(
                  color: const Color(0xffF6F6F7),
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Text('! 메뉴 사진은 연출된 이미지로 실제와 다를 수 있습니다.',
                  style: TextStyle(color: Color(0xffC1C1C1), fontSize: 12.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget sumPriceWidget() {
    return Container(
      height: 72.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('총',
              style: TextStyle(
                  color: black, fontSize: 24.0, fontWeight: FontWeight.w700)),
          priceText(
              price: cart.menuSumPrice ?? 0,
              style: const TextStyle(
                  color: black, fontSize: 24.0, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget orderButtonsTwice(String userEmailId) {
    return SizedBox(
      height: 72.0.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.0, 16.0.h, 24.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: whiteButton('메뉴담기', 'assets/icon/ico-line-cart.png',
                    () async {})),
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              flex: 1,
              child: whiteButton('바로결제', 'assets/icon/ico-line-pay.png', () {
                cudiDialog(context, '결제창으로 넘어갑니다.', '닫기');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
