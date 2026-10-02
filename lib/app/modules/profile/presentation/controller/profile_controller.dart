import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/profile/data/source/profile_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_example_app/app/modules/profile/domain/usecase/get_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final profileControllerProvider =
    ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController(
    getUserUseCase: GetUserUseCase(ProfileImpleRepo()),
  );
});

class ProfileController extends ChangeNotifier with Buffers {
  final GetUserUseCase _getUserUseCase;

  ProfileController({
    required GetUserUseCase getUserUseCase,
  }) : _getUserUseCase = getUserUseCase {
    loadUserProfile();
  }

  UserEntity? _user;
  UserEntity? get user => _user;

  String get userName => _user?.userName ?? '';
  String get email => _user?.email ?? '';
  String get phone => _user?.phone ?? '';

  bool get isLoading => hasLoader('getUserProfile');

  // Notification preferences
  bool pushEnabled = true;
  bool leakageAlert = true;
  bool lowBalanceAlert = true;
  bool arrearsAlert = true;
  bool lowBatteryAlert = true;
  bool offlineAlert = true;
  bool valveResultAlert = true;

  // App settings
  String selectedLanguage = 'English'; // English / Urdu
  String selectedTheme = 'System'; // Light / Dark / System
  String selectedUnit = 'm³'; // m³ / Liters

  Future<void> loadUserProfile() async {
    await executeAPI(
      apiEndPoint: 'getUserProfile',
      showPrompt: false,
      onExecute: () async {
        _user = await _getUserUseCase();
      },
      onError: (e) async {
        _user = null;
      },
    );
  }

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) {
    _user = UserEntity(
      userName: newName,
      email: newEmail,
      phone: newPhone,
    );
    notifyListeners();
  }

  void togglePush(bool val) {
    pushEnabled = val;
    notifyListeners();
  }

  void toggleLeakage(bool val) {
    leakageAlert = val;
    notifyListeners();
  }

  void toggleLowBalance(bool val) {
    lowBalanceAlert = val;
    notifyListeners();
  }

  void toggleArrears(bool val) {
    arrearsAlert = val;
    notifyListeners();
  }

  void toggleLowBattery(bool val) {
    lowBatteryAlert = val;
    notifyListeners();
  }

  void toggleOffline(bool val) {
    offlineAlert = val;
    notifyListeners();
  }

  void toggleValveResult(bool val) {
    valveResultAlert = val;
    notifyListeners();
  }

  void setLanguage(String lang) {
    selectedLanguage = lang;
    notifyListeners();
  }

  void setTheme(String theme) {
    selectedTheme = theme;
    notifyListeners();
  }

  void setUnit(String unit) {
    selectedUnit = unit;
    notifyListeners();
  }
}
