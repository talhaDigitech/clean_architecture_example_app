import 'package:clean_architecture_example_app/app/core/services/mock_data_service.dart';
import 'package:clean_architecture_example_app/app/modules/usage/data/dto/bar_data_point_dto.dart';
import 'package:clean_architecture_example_app/app/modules/usage/data/dto/usage_record_dto.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/repo/usage_repo.dart';

class UsageImpleRepo implements UsageRepo {
  final MockDataService _service = MockDataService();

  @override
  Future<List<UsageRecordDto>> getUsageRecords() async {
    // When real API arrives, replace with ApiService request
    // final response = await _apiService.requestGET(Endpoints.usageRecords);
    final list = await _service.getUsageRecords();
    return list.map((json) => UsageRecordDto.fromJson(json)).toList();
  }

  @override
  Future<Map<String, List<BarDataPointDto>>> getUsageChart() async {
    // When real API arrives, replace with ApiService request
    // final response = await _apiService.requestGET(Endpoints.usageChart);
    final map = await _service.getUsageChart();
    final dailyList = (map['daily'] as List? ?? [])
        .map((e) => BarDataPointDto.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    final weeklyList = (map['weekly'] as List? ?? [])
        .map((e) => BarDataPointDto.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    final monthlyList = (map['monthly'] as List? ?? [])
        .map((e) => BarDataPointDto.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    return {
      'daily': dailyList,
      'weekly': weeklyList,
      'monthly': monthlyList,
    };
  }
}
