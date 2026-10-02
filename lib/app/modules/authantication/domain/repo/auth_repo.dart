import 'package:clean_architecture_example_app/app/modules/authantication/data/dto/login_dto.dart';

abstract interface class AuthRepo {
  Future<LoginDto> login();
}