import 'package:clean_architecture_example_app/app/components/anime_card.dart';
import 'package:clean_architecture_example_app/app/components/paginated_list_view.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/data/dto/get_popular_animes_dto.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/presentation/controller/popular_anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularAnimeScreen extends ConsumerStatefulWidget {
  const PopularAnimeScreen({super.key});

  @override
  ConsumerState<PopularAnimeScreen> createState() => _PopularAnimeScreenState();
}

class _PopularAnimeScreenState extends ConsumerState<PopularAnimeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the first page load after the first frame.
    Future.microtask(
      () => ref.read(popularAnimeProvider.notifier).getPopularAnime(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(popularAnimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Animes'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(popularAnimeProvider.notifier).refresh(),
        child: PaginatedListView<Media>(
          // ── Data ──────────────────────────────────────────────────────
          items: ctrl.animeList,

          // ── Loading states ────────────────────────────────────────────
          isInitialLoading: ctrl.isInitialLoading,
          isLoadingMore: ctrl.isLoadingMore,
          hasMore: ctrl.hasMore,

          // ── Callbacks ─────────────────────────────────────────────────
          onLoadMore: () => ref.read(popularAnimeProvider.notifier).loadMore(),

          // ── Item builder ──────────────────────────────────────────────
          itemBuilder: (context, anime, index) {
            return AnimeCard(
              englishTitle: anime.title?.english ?? 'Unknown',
              nativeTitle: anime.title?.native ?? 'Unknown',
              imageUrl: anime.coverImage?.large ?? '',
              description: anime.description ?? 'No description available.',
            );
          },
        ),
      ),
    );
  }
}