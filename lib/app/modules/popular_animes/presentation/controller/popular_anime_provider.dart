import 'package:clean_architecture_example_app/app/core/handlers/pagination_handler.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/data/dto/get_popular_animes_dto.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/data/source/popular_anime_imply_repo.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/domain/usecase/get_popular_anime_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

final popularAnimeProvider = ChangeNotifierProvider<PopularAnimeProvider>(
  (ref) => PopularAnimeProvider(),
);

class PopularAnimeProvider extends ChangeNotifier
    with Buffers, PaginationHandler {
  final GetPopularAnimeUsecase _getPopularAnimeUsecase = GetPopularAnimeUsecase(
    locator<PopularAnimeImplyRepo>(),
  );

  /// Accumulated list of all fetched media across pages.
  List<Media> animeList = [];

  PopularAnimeProvider() {
    // Initialise pagination — page 1, 10 items per page.
    initPagination(startPage: 1, perPage: 10);
  }

  // ── Initial load (called from initState) ──────────────────────────────────

  /// Fetches the very first page.  Shows the full-screen loader via [Buffers].
  Future<void> getPopularAnime() async {
    await executeAPI(
      apiEndPoint: _loaderKey,
      onExecute: () async {
        animeList.clear();
        resetPagination();
        final dto = await _getPopularAnimeUsecase.execute(1, perPage);
        final items = dto.data?.page?.media ?? [];
        animeList.addAll(items);
        // Advance page manually for the first load
        if (items.length < perPage) {
          markNoMoreData();
        } else {
          advancePage(); // moves currentPage to 2
        }
        notifyListeners();
      },
    );
  }

  // ── Load next page (triggered by scroll) ─────────────────────────────────

  Future<void> loadMore() async {
    await executeNextPage(
      onFetch: (page, perPage) async {
        final dto = await _getPopularAnimeUsecase.execute(page, perPage);
        final items = dto.data?.page?.media ?? [];
        animeList.addAll(items);
        notifyListeners();
        return items.length;
      },
    );
  }

  // ── Pull-to-refresh ──────────────────────────────────────────────────────

  Future<void> refresh() async {
    await getPopularAnime();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// The buffer key used for the initial full-screen loader.
  String get _loaderKey => ApiRoutes.getPopularAnime(page: 1, perPage: perPage);

  bool get isInitialLoading => hasLoader(_loaderKey);
}
