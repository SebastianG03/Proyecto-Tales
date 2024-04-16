import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/presentation/views/loading/tales_grid_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../widgets/components/tales_grid/tales_grid.dart';

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
    final searchState = ref.read(searchStateProvider);
    ref.read(searchProvider.notifier).loadTales(searchState);
  }

  @override
  Widget build(BuildContext context) {
    // final tales = ref.watch(searchProvider.notifier);
    // final talesAsync = ref.watch(talesSearchProvider);
    final searchTales = ref.watch(searchProvider);
    final isSearching = ref.watch(initialSearchLoadingProvider);
    final isLoading = ref.watch(initialSearchLoadingProvider);

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
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              sliver: (isLoading)
                  ? const TalesGridLoader()
                  : SliverGrid.builder(
                      itemCount: searchTales.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 180,
                      ),
                      itemBuilder: (context, index) {
                        if (isSearching) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            ref.read(routerProvider).router.goNamed(
                                AppRoutes.taleDetails,
                                pathParameters: {
                                  'taleId': searchTales[index].id
                                });
                            ref
                                .read(actualTaleProvider.notifier)
                                .update((state) => searchTales[index].id);
                          },
                          child: TaleGridSlide(
                              imageUrl: searchTales[index].getCoverUrl,
                              title: searchTales[index].title,
                              premium: searchTales[index].premium),
                        );
                      },
                    ),
            )
            // TalesGridView(
            //   tales: tales.tales,
            // ),
          ],
        ),
      ),
    );
  }
}
