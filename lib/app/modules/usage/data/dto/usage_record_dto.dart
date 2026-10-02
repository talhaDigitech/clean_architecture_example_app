import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';

class UsageRecordDto {
  final String id;
  final String deviceClock;
  final double deviceTotalData;
  final double consumption;
  final double deviceBalance;
  final String reportReason;
  final bool isAlarm;
  final bool hasDataGapNotice;

  const UsageRecordDto({
    required this.id,
    required this.deviceClock,
    required this.deviceTotalData,
    required this.consumption,
    required this.deviceBalance,
    required this.reportReason,
    this.isAlarm = false,
    this.hasDataGapNotice = false,
  });

  factory UsageRecordDto.fromJson(Map<String, dynamic> json) {
    return UsageRecordDto(
      id: json['id'] as String? ?? '',
      deviceClock: json['deviceClock'] as String? ?? '',
      deviceTotalData: (json['deviceTotalData'] as num?)?.toDouble() ?? 0.0,
      consumption: (json['consumption'] as num?)?.toDouble() ?? 0.0,
      deviceBalance: (json['deviceBalance'] as num?)?.toDouble() ?? 0.0,
      reportReason: json['reportReason'] as String? ?? '',
      isAlarm: json['isAlarm'] as bool? ?? false,
      hasDataGapNotice: json['hasDataGapNotice'] as bool? ?? false,
    );
  }

  UsageRecordEntity toEntity() {
    return UsageRecordEntity(
      id: id,
      deviceClock: deviceClock,
      deviceTotalData: deviceTotalData,
      consumption: consumption,
      deviceBalance: deviceBalance,
      reportReason: reportReason,
      isAlarm: isAlarm,
      hasDataGapNotice: hasDataGapNotice,
    );
  }
}
