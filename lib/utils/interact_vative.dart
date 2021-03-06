import 'dart:async';

import 'package:flutter/services.dart';

class InteractNative {
  /* 通道名称，必须与原生注册的一致*/
  static const flutter_to_native = const MethodChannel(
      'com.bhm.flutter.flutternb.plugins/flutter_to_native');
  static const native_to_flutter =
      const EventChannel('com.bhm.flutter.flutternb.plugins/native_to_flutter');

  static StreamSubscription streamSubscription;
  /*
   * 方法名称，必须与flutter注册的一致
   */
  static final Map<String, String> methodNames = const {
    'register': 'register', //注册
    'login': 'login', //登录
    'logout': 'logout', //退出登录
    'autoLogin': 'autoLogin', //自动登录
    'backPress': 'backPress', //物理返回键触发，主要是让应用返回桌面，而不是关闭应用
    'addFriends': 'addFriends', //添加好友
  };

  /*
  * 调用原生的方法（带参）
  */
  static Future<dynamic> goNativeWithValue(String methodName,
      [Map<String, String> map]) async {
    if (null == map) {
      dynamic future = await flutter_to_native.invokeMethod(methodName);
      return future;
    } else {
      dynamic future = await flutter_to_native.invokeMethod(methodName, map);
      return future;
    }
  }

  /*
  * 原生回调的方法（带参）
  */
  static StreamSubscription dealNativeWithValue(Function event,
      {Function onError, void onDone(), bool cancelOnError}) {
    streamSubscription = native_to_flutter
        .receiveBroadcastStream()
        .listen(event, onError: onError);
    return streamSubscription;
  }

  static void closeStream() {
    if (null != streamSubscription) {
      streamSubscription.cancel();
    }
  }
}
