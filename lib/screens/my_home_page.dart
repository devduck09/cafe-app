import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../utils/provider.dart';
import 'bottoms/favorite_screen.dart';
import 'bottoms/home_screen.dart';
import 'bottoms/my_screen.dart';
import 'bottoms/three_d_screen.dart';
import '../utils/notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int currentPageIndex = 0;

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    currentPageIndex = 0; // 초기값을 0으로 설정
  }

  @override
  Widget build(BuildContext context) {
    String userEmailId = Provider.of<UserProvider>(context).userEmailId;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 59.0.h,
          child: BottomNavigationBar(
            unselectedFontSize: 0.0,
            selectedFontSize: 0.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onDestinationSelected,
            currentIndex: currentPageIndex,
            type: BottomNavigationBarType.fixed,
            items: navigationItems.keys.map((String label) {
              final NavigationItem item = navigationItems[label]!;
              return BottomNavigationBarItem(
                icon: Container(
                    height: 48.0.h,
                    padding: EdgeInsets.only(top: 16.0.h),
                    child: item.icon
                ),
                activeIcon: Container(
                  height: 48.0.h,
                  padding: EdgeInsets.only(top: 16.0.h),
                  child: item.selectedIcon,
                ),
                label: label,
              );
            }).toList(),
          ),
        ),
        body: <Widget>[
          const HomeScreen(),
          ThreeDScreen(userEmailId: userEmailId),
          FavoriteScreen(userEmailId: userEmailId),
          const MyScreen(),
        ][currentPageIndex],
      ),
    );
  }

  // 바텀 네비게이션 바
  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  // 알림
  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions(); // 알림 권한 요청 // 사용자에게 알림 권한을 요청하는 팝업 표시
    // 이때, 사용자가 권한 요청을 허용하거나 거부할 수 있으며, 그에 따라 PermissionStatus 값이 반환되는데,
    // 권한을 허가하지 않으면 앱을 실행할 때마다 요청 팝업이 표시된다.
  }

  // 알림
  void _requestNotificationPermissions() async {
    // 알림 권한 요청
    final status = await NotificationService().requestNotificationPermissions();
    if (status.isDenied && context.mounted) {
      showDialog(
        // 알림 권한이 거부되었을 경우 다이얼로그 출력
        context: context,
        builder: (context) => AlertDialog(
          title: Text('알림 권한이 거부되었습니다.'),
          content: Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  openAppSettings(); // 권한 라이브러리의 것 // 설정 클릭시 권한설정 화면으로 이동
                },
                child: Text('설정')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                child: Text('취소')),
          ],
        ),
      );
    }
  }

  Map<String, NavigationItem> navigationItems = {
    '홈': NavigationItem(
      selectedIcon: Image.asset(
        'assets/icon/navigation_icon_home_selected.png',
        width: 24,
        height: 24,
      ),
      icon: Image.asset(
        'assets/icon/navigation_icon_home.png',
        width: 24,
        height: 24,
      ),
    ),
    '3D': NavigationItem(
      selectedIcon: Image.asset(
        'assets/icon/navigation_icon_3d_selected.png',
        width: 24,
        height: 24,
      ),
      icon: Image.asset(
        'assets/icon/navigation_icon_3d.png',
        width: 24,
        height: 24,
      ),
    ),
    '찜': NavigationItem(
      selectedIcon: Image.asset(
        'assets/icon/navigation_icon_heart_selected.png',
        width: 24,
        height: 24,
      ),
      icon: Image.asset(
        'assets/icon/navigation_icon_heart.png',
        width: 24,
        height: 24,
      ),
    ),
    '마이 페이지': NavigationItem(
      selectedIcon: Image.asset(
        'assets/icon/navigation_icon_mypage_selected.png',
        width: 24,
        height: 24,
      ),
      icon: Image.asset(
        'assets/icon/navigation_icon_mypage.png',
        width: 24,
        height: 24,
      ),
    ),
  };
}

// 바텀 네비게이션 바

class NavigationItem {
  final Image selectedIcon;
  final Image icon;

  NavigationItem({
    required this.selectedIcon,
    required this.icon,
  });
}