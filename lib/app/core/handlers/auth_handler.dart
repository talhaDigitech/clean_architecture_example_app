import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/services/secure_storage.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:flutter/material.dart';


class AuthHandler extends ChangeNotifier {
  static AuthHandler get ref => locator<AuthHandler>();

  User? user;
  String? acessToken;
  bool didLogOut = false;
  bool _isLoggedIn = false;

  Prefs prefs = locator<Prefs>();

  bool get isLoggedIn => _isLoggedIn;

  Future<void> setupUser(User? user, bool isRemember) async {
    this.user = user;
    if (isRemember) {
      await prefs.storeUser(user);
    }
    didLogOut = false;
    notifyListeners();
  }

  Future<void> storeToken(String? acessToken, bool isRemember) async {
    this.acessToken = acessToken;
    _isLoggedIn = acessToken != null;
    if (isRemember) {
      await prefs.storeToken(acessToken);
    }
    notifyListeners();
  }

  Future<void> init() async {
    try {
      didLogOut = false;
      user = await prefs.fetchUser();
      acessToken = await prefs.fetchToken();
      _isLoggedIn = acessToken != null;

      appPrint('[User]: $user');
      appPrint('[AccessToken]: $acessToken');
      notifyListeners();
    } catch (e) {
      appPrint(e);
    }
  }

  void resetAuth() {
    didLogOut = false;
    notifyListeners();
  }

  Future<void> logout() async {
    /// UseCase [didLogOut]: Avoid re-logouts on multiple Ghost login attempts.
    try {
      if (didLogOut) return;
      await Future.wait([prefs.deleteUser(), prefs.deleteToken()]);
      didLogOut = true;
      user = null;
      acessToken = null;
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      appPrint(e);
    }
  }
}
