import 'package:clean_architecture_example_app/app/modules/authantication/data/dto/login_dto.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/entities/login_entity.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/repo/auth_repo.dart';

class LoginUsecase {
  final AuthRepo repo;
  LoginUsecase(this.repo);

  Future<LoginDto> execute(LoginEntity entity) async {
    return await repo.login(entity);
  }
  
}