import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/theme.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  // final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    controller.reload();
    controller.clearLocalStorage();
    // isLoadingNotifier.dispose();
    // progressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _arguements =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }
    // controller = WebViewController.fromPlatformCreationParams(params)
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 자바스크립트 무제한 설정
      // ..setBackgroundColor(const Color(0xffFED790)) // 웹뷰 배경색
      ..setBackgroundColor(const Color(0xff000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            progressNotifier.value = progress.toDouble();
          },
          onPageStarted: (String url) {
            // isLoadingNotifier.value = true;

          },
          onPageFinished: (String url) {
            // isLoadingNotifier.value = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              // 유튜브로 이동 방지
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_arguements["threeDUrl"]));

    return Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            ValueListenableBuilder<double>(
              valueListenable: progressNotifier,
              builder: (context, progressValue, child) {
                return progressValue < 100 ? Center(
                  child: Image.asset(
                    'assets/images/cudi_loading_trans_2.gif',
                    fit: BoxFit.fitWidth,
                  ),
                ) : const SizedBox.shrink();
              },
            ),
          ],
        ),
    );
  }
}