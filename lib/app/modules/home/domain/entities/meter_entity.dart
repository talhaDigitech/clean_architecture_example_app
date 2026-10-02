class MeterEntity {
  final String meterId;
  final String meterName;
  final String meterType;
  final String deviceUserName;
  final int feeStatus;
  final int valveStatus;
  final int voltageStatus;
  final String reportReason;
  final double deviceTotalData;
  final double deviceBalance;
  final double deviceLastData;
  final double deviceSettleDayData;
  final double deviceCurrentData;
  final String deviceSettleDay;
  final double deviceVoltage;
  final int deviceRSSI;
  final String deviceClock;
  final String deviceAddress;
  final int deviceBuyTimes;
  final DateTime updateTime;
  final List<DailyUsageEntity> weeklyUsage;

  const MeterEntity({
    required this.meterId,
    required this.meterName,
    required this.meterType,
    required this.deviceUserName,
    required this.feeStatus,
    required this.valveStatus,
    required this.voltageStatus,
    required this.reportReason,
    required this.deviceTotalData,
    required this.deviceBalance,
    required this.deviceLastData,
    required this.deviceSettleDayData,
    required this.deviceCurrentData,
    required this.deviceSettleDay,
    required this.deviceVoltage,
    required this.deviceRSSI,
    required this.deviceClock,
    required this.deviceAddress,
    required this.deviceBuyTimes,
    required this.updateTime,
    required this.weeklyUsage,
  });

  bool get isValveOpen => valveStatus == 0;
  bool get hasLowBalance => feeStatus != 0;
  bool get hasLowVoltage => voltageStatus != 0;
  bool get hasLeakage =>
      valveStatus == 4 || reportReason.toLowerCase().contains('leak');
  bool get isDataStale =>
      DateTime.now().difference(updateTime).inHours >= 24;

  String get valveStatusLabel {
    switch (valveStatus) {
      case 0:
        return 'Open';
      case 1:
        return 'Closed';
      case 2:
        return 'Abnormal';
      case 3:
        return 'Forced Close';
      case 4:
        return 'Leakage';
      default:
        return 'Unknown ($valveStatus)';
    }
  }

  String get feeStatusLabel {
    switch (feeStatus) {
      case 0:
        return 'Normal';
      case 1:
        return 'Low Balance';
      case 2:
        return 'Arrears';
      default:
        return 'Normal';
    }
  }

  MeterEntity copyWith({
    String? meterId,
    String? meterName,
    String? meterType,
    String? deviceUserName,
    int? feeStatus,
    int? valveStatus,
    int? voltageStatus,
    String? reportReason,
    double? deviceTotalData,
    double? deviceBalance,
    double? deviceLastData,
    double? deviceSettleDayData,
    double? deviceCurrentData,
    String? deviceSettleDay,
    double? deviceVoltage,
    int? deviceRSSI,
    String? deviceClock,
    String? deviceAddress,
    int? deviceBuyTimes,
    DateTime? updateTime,
    List<DailyUsageEntity>? weeklyUsage,
  }) {
    return MeterEntity(
      meterId: meterId ?? this.meterId,
      meterName: meterName ?? this.meterName,
      meterType: meterType ?? this.meterType,
      deviceUserName: deviceUserName ?? this.deviceUserName,
      feeStatus: feeStatus ?? this.feeStatus,
      valveStatus: valveStatus ?? this.valveStatus,
      voltageStatus: voltageStatus ?? this.voltageStatus,
      reportReason: reportReason ?? this.reportReason,
      deviceTotalData: deviceTotalData ?? this.deviceTotalData,
      deviceBalance: deviceBalance ?? this.deviceBalance,
      deviceLastData: deviceLastData ?? this.deviceLastData,
      deviceSettleDayData: deviceSettleDayData ?? this.deviceSettleDayData,
      deviceCurrentData: deviceCurrentData ?? this.deviceCurrentData,
      deviceSettleDay: deviceSettleDay ?? this.deviceSettleDay,
      deviceVoltage: deviceVoltage ?? this.deviceVoltage,
      deviceRSSI: deviceRSSI ?? this.deviceRSSI,
      deviceClock: deviceClock ?? this.deviceClock,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      deviceBuyTimes: deviceBuyTimes ?? this.deviceBuyTimes,
      updateTime: updateTime ?? this.updateTime,
      weeklyUsage: weeklyUsage ?? this.weeklyUsage,
    );
  }
}

class DailyUsageEntity {
  final String day;
  final double value;
  final bool isSelected;

  const DailyUsageEntity({
    required this.day,
    required this.value,
    this.isSelected = false,
  });

  DailyUsageEntity copyWith({
    String? day,
    double? value,
    bool? isSelected,
  }) {
    return DailyUsageEntity(
      day: day ?? this.day,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
