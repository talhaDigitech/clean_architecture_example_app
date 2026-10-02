import 'package:clean_architecture_example_app/app/core/services/mock_data_service.dart';
import 'package:clean_architecture_example_app/app/modules/home/data/dto/meter_dto.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/repo/home_repo.dart';

class HomeImpleRepo implements HomeRepo {
  final MockDataService _mockDataService;

  HomeImpleRepo([MockDataService? mockDataService])
      : _mockDataService = mockDataService ?? MockDataService();

  @override
  Future<List<MeterDto>> getMeters() async {
    // When real API is ready, replace with ApiService request:
    // final response = await _apiService.requestGET(Endpoints.meters);
    final rawList = await _mockDataService.getMeters();
    return rawList.map((json) => MeterDto.fromJson(json)).toList();
  }
}
