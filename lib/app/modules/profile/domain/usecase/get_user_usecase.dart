import 'package:clean_architecture_example_app/app/modules/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_example_app/app/modules/profile/domain/repo/profile_repo.dart';

class GetUserUseCase {
  final ProfileRepo _repo;

  GetUserUseCase(this._repo);

  Future<UserEntity> call() async {
    final dto = await _repo.getUser();
    return dto.toEntity();
  }
}
