import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:clean_architecture_example_app/app/modules/countries/data/dto/get_counties_currency_dto.dart';
import 'package:clean_architecture_example_app/app/modules/countries/domain/repo/country_repo.dart';

class CountryRepoImply implements CountryRepo {
  final ApiService _apiService;
  CountryRepoImply(this._apiService);
  
  @override
  Future<GetCountiesCurrencyDto> getCountries() async {
    try {
      final response = await _apiService.requestGraphQL(
        baseUrl: ApiRoutes.baseUrl2,
        query: ApiRoutes.getCountryCurrency,
        headers: {"Content-Type": "application/json"},
      );

      return getCountiesCurrencyDtoFromJson(response);
    } catch (e) {
      appPrint("Error at getCountries():$e");
      rethrow;
    }
  }
}
