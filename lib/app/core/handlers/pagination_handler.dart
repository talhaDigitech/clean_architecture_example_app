import 'package:clean_architecture_example_app/app/core/utils/app_snack_bar.dart';
import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:flutter/material.dart';

/// A mixin that adds reusable infinite-scroll / pagination behaviour to any
/// [ChangeNotifier] that already uses [Buffers].
///
/// Usage:
/// ```dart
/// class MyProvider extends ChangeNotifier with Buffers, PaginationHandler { … }
/// ```
///
/// In your provider, call [initPagination] once (e.g. in the constructor or
/// first fetch), then call [fetchNextPage] whenever more data is needed.
mixin PaginationHandler on ChangeNotifier, Buffers {
  // ── State ────────────────────────────────────────────────────────────────

  /// Current page number (1-indexed).
  int _currentPage = 1;

  /// Items per page sent to the API.
  int _perPage = 10;

  /// Whether there are more pages to load from the API.
  bool _hasMore = true;

  /// Whether a paginated "load-more" request is in flight.
  bool _isLoadingMore = false;

  // ── Getters ──────────────────────────────────────────────────────────────

  int get currentPage => _currentPage;
  int get perPage => _perPage;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  // ── Initialisation ───────────────────────────────────────────────────────

  /// Call once before the first fetch. Resets all pagination state.
  void initPagination({int startPage = 1, int perPage = 10}) {
    _currentPage = startPage;
    _perPage = perPage;
    _hasMore = true;
    _isLoadingMore = false;
  }

  /// Call this to reset and reload from page 1 (e.g. on pull-to-refresh).
  void resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    notifyListeners();
  }

  // ── Core helpers ─────────────────────────────────────────────────────────

  /// Sets [_isLoadingMore] and notifies listeners.
  @protected
  void setLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  /// Advances the page counter after a successful load.
  @protected
  void advancePage() {
    _currentPage++;
  }

  /// Mark that there are no further pages available.
  @protected
  void markNoMoreData() {
    _hasMore = false;
    notifyListeners();
  }

  // ── executeNextPage ───────────────────────────────────────────────────────

  /// Wraps a paginated API call with complete loading-state and error management:
  ///
  /// - Duplicate in-flight requests are ignored (guarded by [_isLoadingMore]).
  /// - Calls when [hasMore] is false are ignored.
  /// - [isLoadingMore] is set to `true` while the call is running.
  /// - On success: the page counter advances (or [markNoMoreData] is called).
  /// - On error: the page counter stays unchanged (caller can retry by
  ///   scrolling again), the error is shown via [Prompt.showErrorDialog] (same
  ///   mechanism as [Buffers.executeAPI]), and the optional [onError] callback
  ///   is invoked.  The exception is **NOT** rethrown — the mixin handles it.
  ///
  /// [onFetch] must return the number of items the page returned so we can
  /// detect the end of data (returned count < perPage → no more pages).
  Future<void> executeNextPage({
    required Future<int> Function(int page, int perPage) onFetch,
    Future<void> Function(Object error)? onError,
    bool showErrorPrompt = true,
  }) async {
    if (_isLoadingMore || !_hasMore) return;

    setLoadingMore(true);
    try {
      final count = await onFetch(_currentPage, _perPage);
      if (count < _perPage) {
        markNoMoreData();
      } else {
        advancePage();
      }
    } catch (e, stackTrace) {
      // Log for debugging — same style as Buffers.executeAPI.
      debugPrint('[PaginationHandler] error on page $_currentPage: $e');
      debugPrint('[PaginationHandler] stackTrace: $stackTrace');

      // Show the same error dialog the rest of the architecture uses.
      if (showErrorPrompt) {
        Prompt.showErrorDialog(e.toString());
      }

      // The page counter is intentionally NOT advanced — the current page
      // stays the same so the next scroll attempt will retry the same page.
      await onError?.call(e);
    } finally {
      // Always clear the loading flag so the bottom loader disappears.
      setLoadingMore(false);
    }
  }
}
