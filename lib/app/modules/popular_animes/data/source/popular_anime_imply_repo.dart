import 'package:clean_architecture_example_app/app/core/services/network_service/api_service.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/data/dto/get_popular_animes_dto.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/domain/repo/popular_anime_repo.dart';

class PopularAnimeImplyRepo implements PopularAnimeRepo {
  final ApiService _apiService;
  PopularAnimeImplyRepo(this._apiService);
  @override
  Future<GetPopularAnimeDto> getPopularAnime(int page, int perPage) async {
    try {
      final response = await _apiService.requestGraphQL(
        baseUrl: ApiRoutes.baseUrl3,
        query: ApiRoutes.getPopularAnime(page: page, perPage: perPage),
        headers: {"Content-Type": "application/json"},
      );
      return getPopularAnimeDtoFromJson(response);
    } catch (e) {
      appPrint("Error at getPopularAnime:$e");
      rethrow;
    }
  }
}
