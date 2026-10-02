import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/repo/recharge_repo.dart';

class GetRechargeHistoryUseCase {
  final RechargeRepo repo;
  GetRechargeHistoryUseCase(this.repo);

  Future<List<RechargeHistoryEntity>> call() async {
    final dtos = await repo.getRechargeHistory();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
