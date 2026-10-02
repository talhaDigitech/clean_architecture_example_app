import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/home/data/source/home_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/usecase/get_meters_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

enum HomeViewState { loading, loaded, error, empty }

final homeControllerProvider = ChangeNotifierProvider<HomeController>(
  (ref) => HomeController(
    getMetersUseCase: GetMetersUseCase(HomeImpleRepo()),
  ),
);

class HomeController extends ChangeNotifier with Buffers {
  final GetMetersUseCase _getMetersUseCase;

  HomeController({
    required GetMetersUseCase getMetersUseCase,
  }) : _getMetersUseCase = getMetersUseCase {
    loadMeters();
  }

  HomeViewState _state = HomeViewState.loading;
  HomeViewState get state => _state;

  bool get isLoading => hasLoader('getMeters') || _state == HomeViewState.loading;

  int _selectedMeterIndex = 0;
  int get selectedMeterIndex => _selectedMeterIndex;

  int _unreadNotifications = 3;
  int get unreadNotifications => _unreadNotifications;

  bool _isValveOperating = false;
  bool get isValveOperating => _isValveOperating || hasLoader('toggleValve');

  List<MeterEntity> _meters = [];
  List<MeterEntity> get meters => _meters;

  MeterEntity? get currentMeter =>
      (_meters.isNotEmpty && _selectedMeterIndex >= 0 && _selectedMeterIndex < _meters.length)
          ? _meters[_selectedMeterIndex]
          : (_meters.isNotEmpty ? _meters.first : null);

  Future<void> loadMeters() async {
    _state = HomeViewState.loading;
    notifyListeners();

    await executeAPI(
      apiEndPoint: 'getMeters',
      showPrompt: false,
      onExecute: () async {
        final fetchedMeters = await _getMetersUseCase();
        _meters = fetchedMeters;
        _selectedMeterIndex = 0;
        _state = _meters.isEmpty ? HomeViewState.empty : HomeViewState.loaded;
      },
      onError: (e) async {
        _state = HomeViewState.error;
      },
    );
    notifyListeners();
  }

  void selectMeter(int index) {
    if (index >= 0 && index < _meters.length) {
      _selectedMeterIndex = index;
      notifyListeners();
    }
  }

  void clearNotifications() {
    _unreadNotifications = 0;
    notifyListeners();
  }

  /// Toggle valve status (0 = Open, 1 = Closed) with simulated API delay
  Future<bool> toggleValve() async {
    if (_meters.isEmpty) return false;
    _isValveOperating = true;
    addLoader('toggleValve');
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1400));

    final current = currentMeter;
    if (current == null) {
      _isValveOperating = false;
      removeLoader('toggleValve');
      return false;
    }

    final newStatus = current.valveStatus == 0 ? 1 : 0;
    final updatedReason = newStatus == 0
        ? 'Valve Opened by User'
        : 'Valve Closed by User';

    _meters[_selectedMeterIndex] = current.copyWith(
      valveStatus: newStatus,
      reportReason: updatedReason,
      updateTime: DateTime.now(),
    );

    _isValveOperating = false;
    removeLoader('toggleValve');
    notifyListeners();
    return newStatus == 0;
  }

  /// Pull-to-refresh
  Future<void> refreshData() async {
    addLoader('refreshData');
    await Future.delayed(const Duration(milliseconds: 1000));
    final current = currentMeter;
    if (_meters.isNotEmpty && current != null) {
      _meters[_selectedMeterIndex] = current.copyWith(
        updateTime: DateTime.now(),
        deviceCurrentData: current.deviceCurrentData + 0.05,
        deviceTotalData: current.deviceTotalData + 0.05,
      );
      notifyListeners();
    }
    removeLoader('refreshData');
  }

  /// Add balance to current meter (from Recharge module)
  void topUpBalance(double amount) {
    if (_meters.isEmpty) return;
    final current = currentMeter;
    if (current == null) return;
    final newBalance = current.deviceBalance + amount;
    _meters[_selectedMeterIndex] = current.copyWith(
      deviceBalance: newBalance,
      feeStatus: newBalance > 500 ? 0 : (newBalance > 0 ? 1 : 2),
      deviceBuyTimes: current.deviceBuyTimes + 1,
      updateTime: DateTime.now(),
    );
    notifyListeners();
  }

  /// Add new meter
  void addMeter({
    required String meterId,
    required String meterName,
    required String address,
  }) {
    final newMeter = MeterEntity(
      meterId: meterId,
      meterName: meterName,
      meterType: 'Smart Water Meter',
      deviceUserName: _meters.isNotEmpty ? _meters.first.deviceUserName : 'User',
      feeStatus: 0,
      valveStatus: 0,
      voltageStatus: 0,
      reportReason: 'Provisioned Successfully',
      deviceTotalData: 0.0,
      deviceBalance: 1000.0,
      deviceLastData: 0.0,
      deviceSettleDayData: 0.0,
      deviceCurrentData: 0.0,
      deviceSettleDay: '1st of month',
      deviceVoltage: 3.65,
      deviceRSSI: -70,
      deviceClock: DateTime.now().toString().substring(0, 16),
      deviceAddress: address,
      deviceBuyTimes: 1,
      updateTime: DateTime.now(),
      weeklyUsage: const [
        DailyUsageEntity(day: 'Mon', value: 0.0),
        DailyUsageEntity(day: 'Tue', value: 0.0),
        DailyUsageEntity(day: 'Wed', value: 0.0),
        DailyUsageEntity(day: 'Thu', value: 0.0),
        DailyUsageEntity(day: 'Fri', value: 0.0),
        DailyUsageEntity(day: 'Sat', value: 0.0),
        DailyUsageEntity(day: 'Today', value: 0.0, isSelected: true),
      ],
    );
    _meters.add(newMeter);
    _selectedMeterIndex = _meters.length - 1;
    notifyListeners();
  }

  /// Remove meter
  bool removeMeter(int index) {
    if (_meters.length <= 1) return false;
    _meters.removeAt(index);
    if (_selectedMeterIndex >= _meters.length) {
      _selectedMeterIndex = _meters.length - 1;
    }
    notifyListeners();
    return true;
  }

  void setViewState(HomeViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
