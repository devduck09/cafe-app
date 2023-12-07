import 'package:CUDI/config/theme.dart';
import 'package:CUDI/utils/toss/screens/intro.dart';
import 'package:CUDI/utils/toss/screens/result.dart';
import 'package:CUDI/utils/toss/screens/tosspayments/home.dart';
import 'package:CUDI/utils/toss/screens/tosspayments_widget/widget_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

/// TosspaymentsSampleHome is a widget that represents the home screen of the
/// application.
///
/// This is a [StatefulWidget] which maintains the state of the home screen.
class TosspaymentsSampleHome extends StatefulWidget {
  /// Creates a TosspaymentsSampleHome with a given title.
  const TosspaymentsSampleHome({Key? key, required this.title}) : super(key: key);

  /// The title displayed on the home screen.
  final String title;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TosspaymentsSampleHome> createState() => _TosspaymentsSampleHomeState();
}

/// _TosspaymentsSampleHomeState is the logic and internal state for a [TosspaymentsSampleHome] widget.
class _TosspaymentsSampleHomeState extends State<TosspaymentsSampleHome> {
  static const Color primaryColor = Color(0x0f0064ff);
  // static const Color primaryColor = Color(0x0f000000);

  /// Describes the part of the user interface represented by this widget.
  ///
  /// This function returns a [GetMaterialApp] with the [primaryColor] theme.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // 시스템 네비게이션 바
      statusBarColor: Colors.transparent, // 상태 바
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // 시스템 UI가 화면 가장자리로 이동하여 화면의 실제 내용이 상태 바와 네비게이션 바의 아래까지 확장됨
    // 이 코드를 사용하면 앱이 화면의 가장자리까지 확장되어 시스템 바가 투명하게 표시되는 효과를 얻을 수 있습니다.
    // 이는 전체 화면을 활용하고 사용자에게 더 immersive한 경험을 제공하는 데 도움이 됩니다.

    return GetMaterialApp(
      initialRoute: '/widget_home',
      // theme: ThemeData(
      //   primaryColor: primaryColor,
      // ),
      theme: theme(),
      getPages: [
        GetPage(name: '/', page: () => const Intro()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/widget_home', page: () => const WidgetHome()),
        GetPage(name: '/result', page: () => const ResultPage())
      ],
    );
  }
}