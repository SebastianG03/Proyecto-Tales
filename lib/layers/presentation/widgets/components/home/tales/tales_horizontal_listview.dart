import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/enums.dart';
import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/tags_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/router/app_routes.dart';
import '../../../../../application/providers/providers.dart';
import '../../../../../domain/entities/tales/tales_exports.dart';
import 'tales_components.dart';

class HorizontalTalesListView extends ConsumerStatefulWidget {
  final List<Tales> tales;
  final String tag;
  final VoidCallbackAction? loadNextPage;
  const HorizontalTalesListView(
      {super.key, required this.tales, required this.tag, this.loadNextPage});

  @override
  ConsumerState<HorizontalTalesListView> createState() =>
      _HorizontalTalesListViewState();
}

class _HorizontalTalesListViewState
    extends ConsumerState<HorizontalTalesListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          _Titles(tag: widget.tag),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.tales.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // ref.read(searchStateProvider.notifier).update((state) {
                  //   return state.copyWith()
                  // });
                  ref.read(gridTalesStateProvider.notifier).update((state) {
                    final key = TagsHelper.getInstanceOf(widget.tag);
                    if (key == SearchKeys.ageLimit) {
                      return state.copyWith(
                          ageLimit: TagsHelper.getAgeLimitByName(widget.tag));
                    } else {
                      return state.copyWith(
                          accesibility:
                              TagsHelper.getAccessibilityByName(widget.tag));
                    }
                  });

                  ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
                      pathParameters: {'taleId': widget.tales[index].id});
                  ref
                      .read(actualTaleProvider.notifier)
                      .update((state) => widget.tales[index].id);
                },
                child: TaleHorizontalSlide(
                    imageUrl: widget.tales[index].getCoverUrl,
                    title: widget.tales[index].title,
                    premium: widget.tales[index].premium),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Titles extends ConsumerWidget {
  final String tag;
  const _Titles({required this.tag});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        Text(tag, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        IconButton(
          onPressed: () =>
              ref.read(routerProvider).router.goNamed(AppRoutes.talesGridView),
          icon: const Icon(Icons.arrow_forward_ios),
          iconSize: 20,
        )
      ]),
    );
  }
}
