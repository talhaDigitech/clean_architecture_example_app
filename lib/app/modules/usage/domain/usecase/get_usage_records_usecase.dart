import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/repo/usage_repo.dart';

class GetUsageRecordsUseCase {
  final UsageRepo _repo;

  GetUsageRecordsUseCase(this._repo);

  Future<List<UsageRecordEntity>> call() async {
    final dtos = await _repo.getUsageRecords();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
