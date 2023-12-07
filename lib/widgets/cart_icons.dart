import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({super.key});

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setIsCartExist();
    return Stack(
      children: [
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteName.cart),
            child: SvgPicture.asset('assets/icon/ico-line-cart-white-24px.svg'),
          ),
        ),
        if(userProvider.isCartExist) newBadge(),
      ],
    );
  }
}