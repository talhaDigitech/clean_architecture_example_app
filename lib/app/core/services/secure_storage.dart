import 'dart:convert';



import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Prefs {
  ///
  /// Pref Keys
  ///
  static const String _kUser = "user";
  // static const String _kUserSecrets = "userSecrets";
  static const String clockStatus = "clockStatus";
  static const String kAttendanceId = "attendanceId";
  static const String kAccessToken = "accessToken";
  static const String kDownloadedFiles = "downloadFiles";

  final _secureStorage = locator<FlutterSecureStorage>();

  Future<void> store(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  ///
  /// Here we manage app configs
  ///
  Future<void> storeToken(String? token) async {
    try {
      await store(kAccessToken, token!);
    } catch (e) {
      appPrint('Failed to store token');
    }
  }

  Future<String?> fetchToken() async {
    try {
      return await read(kAccessToken);
    } catch (e) {
      appPrint('fetchToken error: $e');
      return null;
    }
  }

  Future<void> deleteToken() async {
    try {
      await delete(kAccessToken);
    } catch (e) {
      appPrint('Failed to delete token');
    }
  }

  Future<void> storeUser(User? user) async {
    try {
      await store(_kUser, jsonEncode(user));
    } catch (e) {
      appPrint('User found null');
    }
  }

  Future<User?> fetchUser() async {
    try {
      String? user = await read(_kUser);
      if (user == null) return null;
      return User.fromJson(jsonDecode(user));
    } catch (e) {
      appPrint('fetchUser error: $e');
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _secureStorage.delete(key: _kUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }

  Future<void> storeList(String key, List<String> values) async {
    await _secureStorage.write(key: key, value: values.join(';'));
  }

  Future<List<String>?> readList(String key) async {
    String? value = await _secureStorage.read(key: key);
    return value?.split(';');
  }
}

class User {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final String phoneNumber;
  final String address;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}

