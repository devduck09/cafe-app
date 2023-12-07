import 'package:CUDI/screens/bottoms/my_screen.dart';
import 'package:CUDI/screens/details/cart_screen.dart';
import 'package:CUDI/screens/details/order_screen.dart';
import 'package:CUDI/screens/details/view_cafe_screen.dart';
import 'package:CUDI/screens/my_home_page.dart';
import 'package:CUDI/screens/starts/launch_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/details/menu_screen.dart';
import '../screens/details/web_view_screen.dart';

class RouteName {
  static const launch = "/launch";
  static const login = "/login";
  static const home = "/home";
  static const storeDetail = "/store_detail";
  static const webView = "/web_view";
  static const test = "/test";
  static const viewCafe = "/view_cafe";
  static const menu = "/menu";
  static const cart = "/cart";
  static const order = "/order";
  static const my = "/my";
}

var namedRoutes = <String, WidgetBuilder> {
  RouteName.launch: (context) => const LaunchScreen(),
  RouteName.home: (context) => const MyHomePage(),
  RouteName.viewCafe: (context) => const ViewCafeScreen(),
  RouteName.menu: (context) => const MenuScreen(),
  RouteName.cart: (context) => const CartScreen(),
  RouteName.order: (context) => const OrderScreen(),
  RouteName.webView: (context) => const WebViewScreen(),
  RouteName.my: (context) => const MyScreen(),
};