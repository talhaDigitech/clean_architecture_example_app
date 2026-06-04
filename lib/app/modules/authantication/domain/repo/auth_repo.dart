import 'package:clean_architecture_example_app/app/modules/authantication/data/dto/login_dto.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/domain/entities/login_entity.dart';

abstract interface class AuthRepo {
  Future<LoginDto> login(LoginEntity entity);
}