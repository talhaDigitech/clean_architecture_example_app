import 'package:flutter/material.dart';

/// A highly reusable, scroll-aware infinite-scroll list widget.
///
/// Drop this widget anywhere you need paginated data:
///
/// ```dart
/// PaginatedListView<MyItem>(
///   items: myItems,
///   isInitialLoading: ctrl.isLoading,
///   isLoadingMore: ctrl.isLoadingMore,
///   hasMore: ctrl.hasMore,
///   onLoadMore: ctrl.loadMore,
///   itemBuilder: (ctx, item, idx) => MyCard(item: item),
/// )
/// ```
///
/// The widget automatically:
/// - Shows a full-screen shimmer/loader while the first page loads.
/// - Shows an empty-state view when the list is empty.
/// - Appends a bottom loader tile when more pages are being fetched.
/// - Shows an "end of list" indicator when there is no more data.
/// - Triggers [onLoadMore] when the scroll reaches the bottom threshold.

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.isInitialLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.emptyWidget,
    this.initialLoadingWidget,
    this.loadMoreWidget,
    this.endWidget,
    this.scrollThreshold = 200.0,
    this.padding,
    this.scrollController,
  });

  /// The flat list of already-fetched items.
  final List<T> items;

  /// Builder for each item row.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Called when the user scrolls near the bottom and more data may exist.
  final VoidCallback onLoadMore;

  /// Shows a full-screen loader while the FIRST page is loading.
  final bool isInitialLoading;

  /// Shows a bottom tile loader while SUBSEQUENT pages are loading.
  final bool isLoadingMore;

  /// Set to false when the API indicates there are no more pages.
  final bool hasMore;

  /// Custom empty-state widget.  Defaults to a built-in empty state.
  final Widget? emptyWidget;

  /// Custom full-screen initial loader.  Defaults to shimmer cards.
  final Widget? initialLoadingWidget;

  /// Custom bottom loader tile.  Defaults to a centred progress indicator.
  final Widget? loadMoreWidget;

  /// Widget shown below the last item when [hasMore] is false.
  final Widget? endWidget;

  /// Pixels before the bottom of the list at which [onLoadMore] fires.
  final double scrollThreshold;

  /// Optional padding around the entire list.
  final EdgeInsetsGeometry? padding;

  /// Supply your own [ScrollController] if needed (e.g. for nested scroll).
  final ScrollController? scrollController;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late final ScrollController _internalController;
  ScrollController get _controller =>
      widget.scrollController ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(PaginatedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the external controller changed, update listeners.
    if (oldWidget.scrollController != widget.scrollController) {
      _controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    // Only dispose the internal controller (external ones belong to caller).
    if (widget.scrollController == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final maxExtent = _controller.position.maxScrollExtent;
    final current = _controller.offset;
    final threshold = widget.scrollThreshold;

    if (current >= maxExtent - threshold &&
        !widget.isLoadingMore &&
        widget.hasMore) {
      widget.onLoadMore();
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // ① Full-screen initial loader
    if (widget.isInitialLoading) {
      return widget.initialLoadingWidget ?? const _ShimmerLoader();
    }

    // ② Empty state
    if (widget.items.isEmpty) {
      return widget.emptyWidget ?? const _EmptyState();
    }

    // ③ Normal list + optional bottom tiles
    final extraCount = widget.isLoadingMore
        ? 1
        : (!widget.hasMore ? 1 : 0); // loader OR end indicator

    return ListView.builder(
      controller: _controller,
      padding: widget.padding ?? const EdgeInsets.only(bottom: 24),
      itemCount: widget.items.length + extraCount,
      itemBuilder: (context, index) {
        // Extra tile at the end
        if (index == widget.items.length) {
          if (widget.isLoadingMore) {
            return widget.loadMoreWidget ?? const _BottomLoader();
          }
          if (!widget.hasMore) {
            return widget.endWidget ?? const _EndOfListTile();
          }
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widgets (all overridable by the caller via the named parameters)
// ─────────────────────────────────────────────────────────────────────────────

/// Animated shimmer skeleton shown during the first page load.
class _ShimmerLoader extends StatefulWidget {
  const _ShimmerLoader();

  @override
  State<_ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<_ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _gradient;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _gradient = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gradient,
      builder: (context, _) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: 6,
          itemBuilder: (context, _) => _ShimmerCard(value: _gradient.value),
        );
      },
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = colorScheme.surfaceContainerHighest.withOpacity(0.5);
    final highlightColor = colorScheme.surfaceContainerHighest.withOpacity(0.9);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment(value - 1, 0),
          end: Alignment(value + 1, 0),
          colors: [baseColor, highlightColor, baseColor],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 95,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerLine(width: 0.6),
                  const SizedBox(height: 8),
                  _shimmerLine(width: 0.4),
                  const SizedBox(height: 12),
                  _shimmerLine(width: 0.9),
                  const SizedBox(height: 6),
                  _shimmerLine(width: 0.75),
                  const SizedBox(height: 6),
                  _shimmerLine(width: 0.55),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _shimmerLine({required double width}) {
    return FractionallySizedBox(
      widthFactor: width,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}

/// Bottom spinner tile shown while loading the next page.
class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Loading more…',
            style: TextStyle(
              fontSize: 13,
              color: color.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small "You've reached the end" tile.
class _EndOfListTile extends StatelessWidget {
  const _EndOfListTile();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: 40,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(width: 12),
          Text(
            'You\'ve seen it all 🎉',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 1,
            width: 40,
            color: colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }
}

/// Default empty-state widget.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 72,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Nothing here yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pull down to refresh',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.outlineVariant,
                ),
          ),
        ],
      ),
    );
  }
}
