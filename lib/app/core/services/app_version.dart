import 'dart:io';

class AppVersionConfig {
  static const String android = "1.0.3";
  static const String ios = "1.0.3";
  static String get getStoreUrl => Platform.isAndroid
      ? playStoreUrl
      : Platform.isIOS
      ? appStoreUrl
      : "";
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.naikify.digitech';
  static const String appStoreUrl =
      'https://apps.apple.com/us/app/naikify-naiki-simplified/id6760806466';
}
