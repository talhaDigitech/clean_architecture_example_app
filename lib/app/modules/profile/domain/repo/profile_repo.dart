import 'package:clean_architecture_example_app/app/modules/profile/data/dto/user_dto.dart';

abstract interface class ProfileRepo {
  Future<UserDto> getUser();
}
