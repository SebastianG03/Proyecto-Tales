import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/router/app_routes.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

class HorizontalTalesListView extends ConsumerWidget {
  final List<String> imageUrl;
  final String tag;
  final List<String> titles;
  final List<bool> premium;
  final VoidCallbackAction? loadNextPage;
  const HorizontalTalesListView(
      {super.key,
      required this.imageUrl,
      required this.tag,
      required this.titles,
      required this.premium,
      this.loadNextPage});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          _Titles(tag: tag),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imageUrl.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => ref.read(routerProvider).router.goNamed(
                    AppRoutes.taleDetails,
                    pathParameters: {'taleId': '1'}),
                child: TaleHorizontalSlide(
                    imageUrl: imageUrl[index],
                    title: titles[index],
                    premium: premium[index]),
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
          onPressed: () => ref
              .read(routerProvider)
              .router
              .goNamed(AppRoutes.talesGridView, pathParameters: {'tag': tag}),
          icon: const Icon(Icons.arrow_forward_ios),
          iconSize: 20,
        )
      ]),
    );
  }
}
