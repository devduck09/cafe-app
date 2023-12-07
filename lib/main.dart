import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/starts/splash_screen.dart';
import 'package:CUDI/utils/notification_service.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/route_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  final notificationService = NotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  debugPrint('API_TOKEN: ${dotenv.env['API_TOKEN']}');
  debugPrint('SECRET_KEY: ${dotenv.env['SECRET_KEY']}');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CudiProvider()),
        ChangeNotifierProvider(create: (context) => SelectedTagProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => UtilProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: false, // 너비와 높이의 최소값에 따라 텍스트를 조정할지 여부
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            home: const SplashScreen(),
            routes: namedRoutes,
          );
        });
  }
}

// 앱 실행 전에 NotificationSevice 인스턴스 생성
// Flutter 엔진 초기화 // 앱이 시작되기 전에 특정 플러그인이나 작업이 먼저 초기화되어야 할 때 사용된다.
// 푸시 알림이 비동기인 await으로 초기화하기 때문에 필수로 수행해야 한다.
// Flutter 프레임워크와 플러그인 사이의 바인딩이 초기화되고, 이후 초기화 작업이 정상적으로 수행되는 것을 보장하기 때문
// 로컬 푸시 알림 초기화
