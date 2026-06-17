import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/countries/data/dto/get_counties_currency_dto.dart';
import 'package:clean_architecture_example_app/app/modules/countries/data/source/country_repo_imply.dart';
import 'package:clean_architecture_example_app/app/modules/countries/domain/usecase/get_country_currency_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

final countriesProvider = ChangeNotifierProvider<CountiesProvider>(
  (ref) => CountiesProvider(),
);

class CountiesProvider extends ChangeNotifier with Buffers {
  final GetCountryCurrencyUsecase _getCountiesCurrencyUsecase = GetCountryCurrencyUsecase(
    locator<CountryRepoImply>()
  );

  GetCountiesCurrencyDto? _getCountiesCurrencyDto;
  GetCountiesCurrencyDto? get getCountiesCurrencyDto => _getCountiesCurrencyDto;

  Future<void> getCountryCurrency()async{
    await executeAPI(apiEndPoint: ApiRoutes.getCountryCurrency, onExecute: ()async{
      _getCountiesCurrencyDto = await _getCountiesCurrencyUsecase.execute();
    });
  }
}