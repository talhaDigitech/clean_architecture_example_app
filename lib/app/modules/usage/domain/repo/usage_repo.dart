import 'package:clean_architecture_example_app/app/modules/usage/data/dto/usage_record_dto.dart';
import 'package:clean_architecture_example_app/app/modules/usage/data/dto/bar_data_point_dto.dart';

abstract interface class UsageRepo {
  Future<List<UsageRecordDto>> getUsageRecords();
  Future<Map<String, List<BarDataPointDto>>> getUsageChart();
}
