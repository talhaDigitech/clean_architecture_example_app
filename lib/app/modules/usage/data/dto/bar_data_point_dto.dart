import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';

class BarDataPointDto {
  final String label;
  final double value;
  final String date;

  const BarDataPointDto({
    required this.label,
    required this.value,
    required this.date,
  });

  factory BarDataPointDto.fromJson(Map<String, dynamic> json) {
    return BarDataPointDto(
      label: json['label'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] as String? ?? '',
    );
  }

  BarDataPointEntity toEntity() {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(date);
    } catch (_) {
      parsedDate = DateTime.now();
    }
    return BarDataPointEntity(
      label: label,
      value: value,
      date: parsedDate,
    );
  }
}
