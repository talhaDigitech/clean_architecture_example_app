import 'package:clean_architecture_example_app/app/modules/countries/data/dto/get_counties_currency_dto.dart';
import 'package:clean_architecture_example_app/app/modules/countries/domain/repo/country_repo.dart';

class GetCountryCurrencyUsecase {
  final CountryRepo _repo;
  GetCountryCurrencyUsecase(this._repo);

  Future<GetCountiesCurrencyDto> execute(){
    return _repo.getCountries();
  }
}