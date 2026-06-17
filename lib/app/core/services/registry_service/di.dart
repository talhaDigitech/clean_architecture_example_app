import 'package:clean_architecture_example_app/app/core/handlers/auth_handler.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/secure_storage.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/data/source/auth_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/countries/data/source/country_repo_imply.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/data/source/popular_anime_imply_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

final locator = GetIt.instance;

void setupLocator() {
  appPrint("***Setup Registry***");
  locator.registerLazySingleton<Prefs>(() => Prefs());
  locator.registerLazySingleton<Client>(() => Client());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<AuthHandler>(() => AuthHandler());
  locator.registerLazySingleton<ImagePicker>(() => ImagePicker());

  locator.registerLazySingleton(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions.defaultOptions,
    ),
  );
  // Auth Repo

  locator.registerFactory<AuthImpleRepo>(
    () => AuthImpleRepo(locator<ApiService>()),
  );


   locator.registerFactory<CountryRepoImply>(
    () => CountryRepoImply(locator<ApiService>()),
  );
   locator.registerFactory<PopularAnimeImplyRepo>(
    () => PopularAnimeImplyRepo(locator<ApiService>()),
  );
 
}
