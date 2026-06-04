// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:naikify_mobile_app/src/core/utils/app_logger.dart';

// class DeviceInfoService {
//   DeviceInfoService._();
//   static final DeviceInfoService instance = DeviceInfoService._();
//   final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

//   /// Gets the full device name (e.g., "moto g41" or "iPhone 13")
//   Future<String> getDeviceName() async {
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//         appPrint("Android Device Name: ${androidInfo.model}");
//         return "${androidInfo.manufacturer} ${androidInfo.model}";
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//         appPrint("IOS Device Name: ${iosInfo.name}");
//         return iosInfo.name;
//       }
//       return 'Unknown Device';
//     } catch (e) {
//       return 'Unknown Device';
//     }
//   }

//   /// Gets a unique device ID (identifierForVendor for iOS, build ID for Android)
//   Future<String> getDeviceId() async {
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//         appPrint("Android Device ID: ${androidInfo.id}");
//         return androidInfo.id;
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//         appPrint("IOS Device ID: ${iosInfo.identifierForVendor}");
//         return iosInfo.identifierForVendor ?? 'Unknown ID';
//       }
//       return 'Unknown ID';
//     } catch (e) {
//       return 'Unknown ID';
//     }
//   }
//   // get app version
//   Future<String> getAppVersion() async {
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//         appPrint("Android App Version: ${androidInfo.version.release}");
//         return androidInfo.version.release;
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//         appPrint("IOS App Version: ${iosInfo.systemVersion}");
//         return iosInfo.systemVersion;
//       }
//       return 'Unknown App Version';
//     } catch (e) {
//       return 'Unknown App Version';
//     }
//   }

//   // version
  
// }
