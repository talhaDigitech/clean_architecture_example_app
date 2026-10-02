import 'package:clean_architecture_example_app/app/core/services/mock_data_service.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/data/dto/recharge_history_dto.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/repo/recharge_repo.dart';

class RechargeImpleRepo implements RechargeRepo {
  final MockDataService _mockDataService;

  RechargeImpleRepo([MockDataService? mockDataService])
      : _mockDataService = mockDataService ?? MockDataService();

  @override
  Future<List<RechargeHistoryDto>> getRechargeHistory() async {
    // When real API arrives, replace with ApiService request
    // final response = await _apiService.requestGET(Endpoints.rechargeHistory);
    final rawList = await _mockDataService.getRechargeHistory();
    return rawList.map((json) => RechargeHistoryDto.fromJson(json)).toList();
  }
}
