import 'package:clean_architecture_example_app/app/modules/countries/data/dto/get_counties_currency_dto.dart';

abstract interface class  CountryRepo {
  Future<GetCountiesCurrencyDto> getCountries();
}