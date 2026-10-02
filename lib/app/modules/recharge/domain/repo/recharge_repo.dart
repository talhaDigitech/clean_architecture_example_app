import 'package:clean_architecture_example_app/app/modules/recharge/data/dto/recharge_history_dto.dart';

abstract interface class RechargeRepo {
  Future<List<RechargeHistoryDto>> getRechargeHistory();
}
