import 'package:clean_architecture_example_app/app/modules/home/data/dto/meter_dto.dart';

abstract interface class HomeRepo {
  Future<List<MeterDto>> getMeters();
}
