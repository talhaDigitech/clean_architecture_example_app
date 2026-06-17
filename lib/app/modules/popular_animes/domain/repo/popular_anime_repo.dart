import 'package:clean_architecture_example_app/app/modules/popular_animes/data/dto/get_popular_animes_dto.dart';

abstract interface class PopularAnimeRepo {
  Future<GetPopularAnimeDto> getPopularAnime(int page , int perPage);
}