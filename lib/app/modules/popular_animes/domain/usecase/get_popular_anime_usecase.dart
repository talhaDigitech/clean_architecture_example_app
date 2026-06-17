import 'package:clean_architecture_example_app/app/modules/popular_animes/data/dto/get_popular_animes_dto.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/domain/repo/popular_anime_repo.dart';

class GetPopularAnimeUsecase {
  final PopularAnimeRepo _repo;
  GetPopularAnimeUsecase(this._repo);

  Future<GetPopularAnimeDto> execute(int page,int perPage){
    return _repo.getPopularAnime(page, perPage);
  }
}