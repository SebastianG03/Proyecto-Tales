import 'package:cuentos_pasantia/config/router/app_routes.dart';
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
    // ref.read(searchProvider.notifier).init();
    // _scrollController.addListener(() {
    //   _listen;
    // });
  }

  // void _listen() {
  // if (ref.read(searchProvider).isLoading) return;
  //   if (_scrollController.position.pixels + 10 >
  //       _scrollController.position.maxScrollExtent) {
  //     if (ref.read(searchProvider.notifier).tales.length > 40) return;
  //     ref.read(searchProvider.notifier).init();
  //     debugPrint('Loading');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final tales = ref.watch(searchProvider.notifier);
    final talesAsync = ref.watch(talesSearchProvider);
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
              sliver: talesAsync.when(data: (tales) {
                return SliverGrid.builder(
                  itemCount: tales.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 180,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(routerProvider).router.goNamed(
                            AppRoutes.taleDetails,
                            pathParameters: {'taleId': tales[index].id});
                        ref
                            .read(actualTaleProvider.notifier)
                            .update((state) => tales[index].id);
                      },
                      child: TaleGridSlide(
                          imageUrl: tales[index].getCoverUrl,
                          title: tales[index].title,
                          premium: tales[index].premium),
                    );
                  },
                );
              }, error: (error, stack) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error: $error'),
                  ),
                );
              }, loading: () {
                return SliverToBoxAdapter(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                );
              }),
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
