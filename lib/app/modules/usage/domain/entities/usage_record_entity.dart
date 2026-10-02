enum UsageRange { today, days7, days30, thisMonth, lastMonth, custom }

enum ChartTimeMode { daily, weekly, monthly }

enum EventFilter {
  all,
  leakage,
  valveAction,
  lowBattery,
  arrears,
  magnetic,
  alarmsOnly,
}

class BarDataPointEntity {
  final String label;
  final double value; // m³
  final DateTime date;

  const BarDataPointEntity({
    required this.label,
    required this.value,
    required this.date,
  });
}

class UsageRecordEntity {
  final String id;
  final String deviceClock;
  final double deviceTotalData; // Cumulative m³
  final double consumption; // Delta m³
  final double deviceBalance;
  final String reportReason;
  final bool isAlarm;
  final bool hasDataGapNotice;

  const UsageRecordEntity({
    required this.id,
    required this.deviceClock,
    required this.deviceTotalData,
    required this.consumption,
    required this.deviceBalance,
    required this.reportReason,
    this.isAlarm = false,
    this.hasDataGapNotice = false,
  });
}
