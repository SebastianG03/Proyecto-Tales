import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  int itemCount = 16;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (isLoading) return;
      if (_scrollController.position.pixels + 10 >
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
          Future.delayed(const Duration(seconds: 40));
          itemCount += 16;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: itemCount,
            ),
          ],
        ),
      ),
    );
  }
}
