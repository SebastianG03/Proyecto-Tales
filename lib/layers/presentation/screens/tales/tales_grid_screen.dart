import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/images/network_image.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';

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
    final searchState = ref.read(gridTalesStateProvider);
    ref.read(filterProvider.notifier).loadTales(searchState);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        ref.read(filterProvider.notifier).loadMoreTales();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tales = ref.watch(searchProvider.notifier);
    // final talesAsync = ref.watch(talesSearchProvider);
    final searchTales = ref.watch(filterProvider);
    // final isLoading = ref.watch(initialSearchLoadingProvider);
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(leading: true),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: searchTales.length,
          itemBuilder: (context, index) {
            String accesibility =
                (searchTales[index].premium) ? "Premium" : "Gratis";

            return GestureDetector(
              onTap: () => _onTap(searchTales[index]),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        url: searchTales[index].getCoverUrl,
                        boxFit: BoxFit.scaleDown,
                        borderRadius: 2.5,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchTales[index].title.length > 24
                                ? "${searchTales[index].title.substring(0, 24)}..."
                                : searchTales[index].title,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(accesibility,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  void _onTap(Tales tale) {
    ref
        .read(routerProvider)
        .router
        .goNamed(AppRoutes.taleDetails, pathParameters: {'taleId': tale.id});
    ref.read(actualTaleProvider.notifier).update((state) => tale.id);
  }
}
