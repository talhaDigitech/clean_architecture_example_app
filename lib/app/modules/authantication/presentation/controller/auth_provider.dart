import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/services/routing_service/app_routes.dart';
import 'package:clean_architecture_example_app/app/core/services/routing_service/named_routes.dart';
import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/data/dto/login_dto.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/data/source/auth_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/entities/login_entity.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/usecase/login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) => AuthProvider(),
);

class AuthProvider extends ChangeNotifier with Buffers {
  final LoginUsecase _loginUsecase = LoginUsecase(
    AuthImpleRepo(locator<ApiService>()),
  );

  LoginDto? loginDto;

  Future<void> login(LoginEntity entity) async {
    await executeAPI(
      apiEndPoint: ApiRoutes.login,
      onExecute: () async {
        loginDto = await _loginUsecase.execute(entity);
        AppRouterGo.pushReplacement(homeScreen);
      },
    );
  }
}
