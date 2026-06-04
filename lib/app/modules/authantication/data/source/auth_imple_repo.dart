import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/entities/loader_entity.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/data/dto/login_dto.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/entities/login_entity.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/repo/auth_repo.dart';

class AuthImpleRepo implements AuthRepo {
  final ApiService _apiService;
  AuthImpleRepo(this._apiService);
  @override
  Future<LoginDto> login(LoginEntity entity) async {
    try {
      final response = await _apiService.requestPOST(
        apiRoute: ApiRouteEntity(
          base: ApiRoutes.baseUrl,
          endpoint: ApiRoutes.login,
        ),
        data: entity.toJson(),
        headers: {"Content-Type": "application/json"},
        
      );
      return loginDtoFromJson(response);
    } catch (e) {
      appPrint("Login Error: $e");
      rethrow;
    }
  }
}
