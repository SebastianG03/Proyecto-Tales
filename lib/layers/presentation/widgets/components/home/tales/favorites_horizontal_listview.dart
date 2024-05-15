import 'package:cuentos_pasantia/layers/presentation/widgets/components/home/tales/slides/horizontal_slide_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/router/app_routes.dart';
import '../../../../../application/providers/providers.dart';
import '../../../../../domain/entities/user/users.dart';
import 'tales_components.dart';

class FavoritesHorizontalListView extends ConsumerStatefulWidget {
  final List<UserTales> usertales;
  final VoidCallbackAction? loadNextPage;
  const FavoritesHorizontalListView(
      {super.key, required this.usertales, this.loadNextPage});

  @override
  ConsumerState<FavoritesHorizontalListView> createState() =>
      _FavoritesHorizontalListViewState();
}

class _FavoritesHorizontalListViewState
    extends ConsumerState<FavoritesHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.usertales.isNotEmpty,
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            const HorizontalSlideTitle(
              tag: 'Favoritos',
              height: 50,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.usertales.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: TaleHorizontalSlide(
                    imageUrl: widget.usertales[index].coverUrl,
                    title: widget.usertales[index].taleTitle,
                    premium: null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    ref
        .read(actualTaleProvider.notifier)
        .update((state) => widget.usertales[index].taleId);

    ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
        pathParameters: {'taleId': widget.usertales[index].taleId});
  }
}
