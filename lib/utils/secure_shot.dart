import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

abstract class SecureShot {
  SecureShot._();

  static const _channel = MethodChannel('secureShotChannel');

  static void on() {
    if (Platform.isAndroid) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else if (Platform.isIOS) {
      // _channel.invokeMethod("secureIOS");
      // _channel.invokeMethod("secureIOS", {"message": "보안상의 이유로 스크린샷이 금지되었습니다."});
      _channel.invokeMethod("secureIOS", {"message": "화면 캡처는 보안상의 이유로 금지되어 있습니다."});
    }
  }

  static void off() {
    if (Platform.isAndroid) {
      FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    } else if (Platform.isIOS) {
      _channel.invokeMethod("unSecureIOS");
    }
  }
}