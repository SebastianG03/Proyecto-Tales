import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/enums.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/home/tales/slides/horizontal_slide_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/router/app_routes.dart';
import '../../../../../application/providers/providers.dart';
import '../../../../../domain/entities/tales/tales_exports.dart';
import 'tales_components.dart';

class HorizontalTalesListView extends ConsumerStatefulWidget {
  final List<Tales> tales;
  final SearchKeys searchKey;
  final String tag;
  final VoidCallbackAction? loadNextPage;
  const HorizontalTalesListView(
      {super.key,
      required this.tales,
      required this.searchKey,
      required this.tag,
      this.loadNextPage});

  @override
  ConsumerState<HorizontalTalesListView> createState() =>
      _HorizontalTalesListViewState();
}

class _HorizontalTalesListViewState
    extends ConsumerState<HorizontalTalesListView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.tales.isNotEmpty,
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            HorizontalSlideTitle(
              tag: widget.tag,
              onTap: () => _onTagTapped(),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.tales.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: TaleHorizontalSlide(
                      imageUrl: widget.tales[index].getCoverUrl,
                      title: widget.tales[index].title,
                      premium: widget.tales[index].premium),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTagTapped() {
    ref
        .read(gridTalesStateProvider.notifier)
        .update((state) => state.copyWith(principalTag: widget.tag));
    ref.read(routerProvider).router.goNamed(AppRoutes.talesGridView);
  }

  void _onItemTapped(int index) async {
    ref.read(gridTalesStateProvider.notifier).update((state) {
      return state.updateByKey(widget.searchKey, widget.tag);
    });

    ref
        .read(actualTaleProvider.notifier)
        .update((state) => widget.tales[index].id);

    ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
        pathParameters: {'taleId': widget.tales[index].id});
  }
}
