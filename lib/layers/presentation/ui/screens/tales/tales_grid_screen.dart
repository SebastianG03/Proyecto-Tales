import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/views/tales/tales_grid_view.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales_grid/tales_grid.dart';

class TalesGridScreen extends ConsumerStatefulWidget {
  final bool isSearching;
  const TalesGridScreen({super.key, this.isSearching = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TalesGridScreenState();
}

class _TalesGridScreenState extends ConsumerState<TalesGridScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(searchProvider.notifier).init();
    _scrollController.addListener(() {
      _listen;
    });
  }

  void _listen() {
    // if (ref.read(searchProvider).isLoading) return;
    if (_scrollController.position.pixels + 10 >
        _scrollController.position.maxScrollExtent) {
      if (ref.read(searchProvider.notifier).tales.length > 40) return;
      ref.read(searchProvider.notifier).init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tales = ref.watch(searchProvider.notifier);
    return SafeArea(
      child: PlatformScaffold(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            GridAppBar(isSearching: widget.isSearching),
            SliverList.list(
              children: [
                Visibility(
                    visible: widget.isSearching,
                    child: const GridTalesFilters()),
              ],
            ),
            TalesGridView(
              tales: tales.tales,
            ),
          ],
        ),
      ),
    );
  }
}
