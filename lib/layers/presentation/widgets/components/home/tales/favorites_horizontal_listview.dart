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
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          const _Titles(tag: 'Favoritos'),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.usertales.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  ref
                      .read(actualTaleProvider.notifier)
                      .update((state) => widget.usertales[index].taleId);

                  ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
                      pathParameters: {
                        'taleId': widget.usertales[index].taleId
                      });
                },
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
      height: 50.0,
      child: Row(children: [
        Text(tag, style: const TextStyle(fontSize: 16)),
      ]),
    );
  }
}
