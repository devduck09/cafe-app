import 'package:CUDI/widgets/sheets/order_bottom_sheet_opend.dart';
import 'package:flutter/material.dart';

import '../config/route_name.dart';
import '../config/theme.dart';
import 'etc/cudi_util_widgets.dart';
import 'etc/cudi_widgets.dart';

class ClosedSheet extends StatelessWidget {
  const ClosedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: black,
            builder: (context) {
              return const OrderBottomSheetOpened();
            },
          ).then((value) {
            snackBar(context, '장바구니에 상품을 담았습니다.',
                label: '보러가기',
                click: () => Navigator.pushNamed(context, RouteName.cart));
          });
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < -20.0) {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: black,
              builder: (context) {
                return const OrderBottomSheetOpened();
              },
            ).then((value) {
              snackBar(context, '장바구니에 상품을 담았습니다.',
                  label: '보러가기',
                  click: () => Navigator.pushNamed(context, RouteName.cart));
            });
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: menuInfo(context),
              ),
            ],
          ),
        ));
  }
}
