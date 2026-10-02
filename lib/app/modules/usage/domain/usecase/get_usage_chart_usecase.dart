import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/repo/usage_repo.dart';

class GetUsageChartUseCase {
  final UsageRepo _repo;

  GetUsageChartUseCase(this._repo);

  Future<Map<ChartTimeMode, List<BarDataPointEntity>>> call() async {
    final map = await _repo.getUsageChart();
    return {
      ChartTimeMode.daily: (map['daily'] ?? []).map((dto) => dto.toEntity()).toList(),
      ChartTimeMode.weekly: (map['weekly'] ?? []).map((dto) => dto.toEntity()).toList(),
      ChartTimeMode.monthly: (map['monthly'] ?? []).map((dto) => dto.toEntity()).toList(),
    };
  }
}
