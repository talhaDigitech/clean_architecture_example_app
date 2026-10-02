import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';

class MeterDto {
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
  final List<DailyUsageDto> weeklyUsage;

  MeterDto({
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

  factory MeterDto.fromJson(Map<String, dynamic> json) => MeterDto(
        meterId: json["meterId"] ?? "",
        meterName: json["meterName"] ?? "",
        meterType: json["meterType"] ?? "",
        deviceUserName: json["deviceUserName"] ?? "",
        feeStatus: json["feeStatus"] ?? 0,
        valveStatus: json["valveStatus"] ?? 0,
        voltageStatus: json["voltageStatus"] ?? 0,
        reportReason: json["reportReason"] ?? "",
        deviceTotalData: (json["deviceTotalData"] as num?)?.toDouble() ?? 0.0,
        deviceBalance: (json["deviceBalance"] as num?)?.toDouble() ?? 0.0,
        deviceLastData: (json["deviceLastData"] as num?)?.toDouble() ?? 0.0,
        deviceSettleDayData:
            (json["deviceSettleDayData"] as num?)?.toDouble() ?? 0.0,
        deviceCurrentData:
            (json["deviceCurrentData"] as num?)?.toDouble() ?? 0.0,
        deviceSettleDay: json["deviceSettleDay"] ?? "",
        deviceVoltage: (json["deviceVoltage"] as num?)?.toDouble() ?? 0.0,
        deviceRSSI: json["deviceRSSI"] ?? 0,
        deviceClock: json["deviceClock"] ?? "",
        deviceAddress: json["deviceAddress"] ?? "",
        deviceBuyTimes: json["deviceBuyTimes"] ?? 0,
        updateTime: json["updateTime"] != null
            ? DateTime.tryParse(json["updateTime"]) ?? DateTime.now()
            : DateTime.now(),
        weeklyUsage: json["weeklyUsage"] != null
            ? (json["weeklyUsage"] as List)
                .map((e) => DailyUsageDto.fromJson(Map<String, dynamic>.from(e)))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "meterId": meterId,
        "meterName": meterName,
        "meterType": meterType,
        "deviceUserName": deviceUserName,
        "feeStatus": feeStatus,
        "valveStatus": valveStatus,
        "voltageStatus": voltageStatus,
        "reportReason": reportReason,
        "deviceTotalData": deviceTotalData,
        "deviceBalance": deviceBalance,
        "deviceLastData": deviceLastData,
        "deviceSettleDayData": deviceSettleDayData,
        "deviceCurrentData": deviceCurrentData,
        "deviceSettleDay": deviceSettleDay,
        "deviceVoltage": deviceVoltage,
        "deviceRSSI": deviceRSSI,
        "deviceClock": deviceClock,
        "deviceAddress": deviceAddress,
        "deviceBuyTimes": deviceBuyTimes,
        "updateTime": updateTime.toIso8601String(),
        "weeklyUsage": weeklyUsage.map((x) => x.toJson()).toList(),
      };

  MeterEntity toEntity() => MeterEntity(
        meterId: meterId,
        meterName: meterName,
        meterType: meterType,
        deviceUserName: deviceUserName,
        feeStatus: feeStatus,
        valveStatus: valveStatus,
        voltageStatus: voltageStatus,
        reportReason: reportReason,
        deviceTotalData: deviceTotalData,
        deviceBalance: deviceBalance,
        deviceLastData: deviceLastData,
        deviceSettleDayData: deviceSettleDayData,
        deviceCurrentData: deviceCurrentData,
        deviceSettleDay: deviceSettleDay,
        deviceVoltage: deviceVoltage,
        deviceRSSI: deviceRSSI,
        deviceClock: deviceClock,
        deviceAddress: deviceAddress,
        deviceBuyTimes: deviceBuyTimes,
        updateTime: updateTime,
        weeklyUsage: weeklyUsage.map((e) => e.toEntity()).toList(),
      );
}

class DailyUsageDto {
  final String day;
  final double value;
  final bool isSelected;

  DailyUsageDto({
    required this.day,
    required this.value,
    this.isSelected = false,
  });

  factory DailyUsageDto.fromJson(Map<String, dynamic> json) => DailyUsageDto(
        day: json["day"] ?? "",
        value: (json["value"] as num?)?.toDouble() ?? 0.0,
        isSelected: json["isSelected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "value": value,
        "isSelected": isSelected,
      };

  DailyUsageEntity toEntity() => DailyUsageEntity(
        day: day,
        value: value,
        isSelected: isSelected,
      );
}
