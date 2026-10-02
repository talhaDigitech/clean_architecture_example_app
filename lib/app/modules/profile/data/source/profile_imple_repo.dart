import 'package:clean_architecture_example_app/app/core/services/mock_data_service.dart';
import 'package:clean_architecture_example_app/app/modules/profile/data/dto/user_dto.dart';
import 'package:clean_architecture_example_app/app/modules/profile/domain/repo/profile_repo.dart';

class ProfileImpleRepo implements ProfileRepo {
  final MockDataService _service = MockDataService();

  @override
  Future<UserDto> getUser() async {
    // When real API arrives, replace with ApiService request
    // final response = await _apiService.requestGET(Endpoints.profile);
    final map = await _service.getUser();
    return UserDto.fromJson(map);
  }
}
