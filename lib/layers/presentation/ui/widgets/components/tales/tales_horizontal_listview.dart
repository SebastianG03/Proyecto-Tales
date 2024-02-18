import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

class HorizontalTalesListView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
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
            itemBuilder: (context, index) => TaleHorizontalSlide(
                imageUrl: imageUrl[index],
                title: titles[index],
                premium: premium[index]),
          ))
        ],
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  final String tag;
  const _Titles({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        Text(tag, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_ios),
          iconSize: 20,
        )
      ]),
    );
  }
}
