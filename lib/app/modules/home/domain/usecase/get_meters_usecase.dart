import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/repo/home_repo.dart';

class GetMetersUseCase {
  final HomeRepo repo;
  GetMetersUseCase(this.repo);

  Future<List<MeterEntity>> call() async {
    final dtos = await repo.getMeters();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
