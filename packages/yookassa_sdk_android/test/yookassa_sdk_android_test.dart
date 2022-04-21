// import 'package:flutter_test/flutter_test.dart';
// import 'package:yookassa_sdk_android/yookassa_sdk_android.dart';
// import 'package:yookassa_sdk_android/yookassa_sdk_android_platform_interface.dart';
// import 'package:yookassa_sdk_android/yookassa_sdk_android_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockYookassaSdkAndroidPlatform
//     with MockPlatformInterfaceMixin
//     implements YookassaSdkAndroidPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final YookassaSdkAndroidPlatform initialPlatform = YookassaSdkAndroidPlatform.instance;
//
//   test('$MethodChannelYookassaSdkAndroid is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelYookassaSdkAndroid>());
//   });
//
//   test('getPlatformVersion', () async {
//     YookassaSdkAndroid yookassaSdkAndroidPlugin = YookassaSdkAndroid();
//     MockYookassaSdkAndroidPlatform fakePlatform = MockYookassaSdkAndroidPlatform();
//     YookassaSdkAndroidPlatform.instance = fakePlatform;
//
//     expect(await yookassaSdkAndroidPlugin.getPlatformVersion(), '42');
//   });
// }
