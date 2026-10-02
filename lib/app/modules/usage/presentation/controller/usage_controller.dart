import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/usage/data/source/usage_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/usecase/get_usage_chart_usecase.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/usecase/get_usage_records_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final usageControllerProvider = ChangeNotifierProvider<UsageController>(
  (ref) {
    final repo = UsageImpleRepo();
    return UsageController(
      getUsageRecordsUseCase: GetUsageRecordsUseCase(repo),
      getUsageChartUseCase: GetUsageChartUseCase(repo),
    );
  },
);

class UsageController extends ChangeNotifier with Buffers {
  final GetUsageRecordsUseCase _getUsageRecordsUseCase;
  final GetUsageChartUseCase _getUsageChartUseCase;

  UsageController({
    required GetUsageRecordsUseCase getUsageRecordsUseCase,
    required GetUsageChartUseCase getUsageChartUseCase,
  })  : _getUsageRecordsUseCase = getUsageRecordsUseCase,
        _getUsageChartUseCase = getUsageChartUseCase {
    loadUsageData();
  }

  UsageRange _range = UsageRange.days7;
  UsageRange get range => _range;

  ChartTimeMode _timeMode = ChartTimeMode.daily;
  ChartTimeMode get timeMode => _timeMode;

  EventFilter _filter = EventFilter.all;
  EventFilter get filter => _filter;

  DateTimeRange? _customDateRange;
  DateTimeRange? get customDateRange => _customDateRange;

  bool get isLoading => hasLoader('getUsageData');

  bool _showHourlyPushCard = true;
  bool get showHourlyPushCard => _showHourlyPushCard;

  Map<ChartTimeMode, List<BarDataPointEntity>> _chartDataMap = {};
  List<UsageRecordEntity> _rawRecords = [];

  Future<void> loadUsageData() async {
    await executeAPI(
      apiEndPoint: 'getUsageData',
      showPrompt: false,
      onExecute: () async {
        final records = await _getUsageRecordsUseCase();
        final chart = await _getUsageChartUseCase();
        _rawRecords = records;
        _chartDataMap = chart;
      },
      onError: (e) async {
        _rawRecords = [];
        _chartDataMap = {};
      },
    );
  }

  void toggleHourlyCard() {
    _showHourlyPushCard = !_showHourlyPushCard;
    notifyListeners();
  }

  void setRange(UsageRange newRange) {
    _range = newRange;
    _simulateLoading();
  }

  void setCustomRange(DateTimeRange range) {
    _customDateRange = range;
    _range = UsageRange.custom;
    _simulateLoading();
  }

  void setTimeMode(ChartTimeMode mode) {
    _timeMode = mode;
    notifyListeners();
  }

  void setFilter(EventFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> _simulateLoading() async {
    addLoader('getUsageData');
    await Future.delayed(const Duration(milliseconds: 350));
    removeLoader('getUsageData');
  }

  List<BarDataPointEntity> get chartData => _chartDataMap[_timeMode] ?? [];

  double get totalUsage =>
      chartData.fold(0.0, (sum, item) => sum + item.value);

  double get dailyAverage =>
      chartData.isEmpty ? 0 : totalUsage / chartData.length;

  BarDataPointEntity get peakDay {
    if (chartData.isEmpty) {
      return BarDataPointEntity(label: '-', value: 0.0, date: DateTime.now());
    }
    return chartData.reduce(
      (curr, next) => curr.value > next.value ? curr : next,
    );
  }

  String get comparisonString => '+8.4% vs last period';

  List<UsageRecordEntity> get records {
    switch (_filter) {
      case EventFilter.all:
        return _rawRecords;
      case EventFilter.alarmsOnly:
        return _rawRecords.where((r) => r.isAlarm).toList();
      case EventFilter.leakage:
        return _rawRecords
            .where((r) => r.reportReason.toLowerCase().contains('leak'))
            .toList();
      case EventFilter.valveAction:
        return _rawRecords
            .where((r) => r.reportReason.toLowerCase().contains('valve'))
            .toList();
      case EventFilter.lowBattery:
        return _rawRecords
            .where((r) => r.reportReason.toLowerCase().contains('battery'))
            .toList();
      case EventFilter.arrears:
        return _rawRecords
            .where((r) => r.reportReason.toLowerCase().contains('arrears'))
            .toList();
      case EventFilter.magnetic:
        return _rawRecords
            .where((r) => r.reportReason.toLowerCase().contains('magnetic'))
            .toList();
    }
  }
}
