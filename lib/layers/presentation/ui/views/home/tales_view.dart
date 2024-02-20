import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

import '../../widgets/shared/custom_appbar.dart';

class TalesView extends StatelessWidget {
  const TalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final urls = getUrls();
    final titles = getTitles();
    final premium = [true, false, true, false, true, false];
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[
                TalesSlideshow(
                  imageUrl: urls,
                  title: titles,
                ),
                const SizedBox(
                  height: 20,
                ),
                HorizontalTalesListView(
                    imageUrl: urls,
                    tag: 'Nuevos',
                    titles: titles,
                    premium: premium),
                HorizontalTalesListView(
                    imageUrl: urls,
                    tag: 'Tendencias',
                    titles: titles,
                    premium: premium),
                HorizontalTalesListView(
                    imageUrl: urls,
                    tag: 'Acción',
                    titles: titles,
                    premium: premium)
              ],
            );
          },
          childCount: 1,
        ))
      ],
    );
  }

  List<String> getUrls() {
    return [
      'assets/tales_sample/portada1.jpg',
      'assets/tales_sample/portada2.jpg',
      'assets/tales_sample/portada3.jpg',
      'assets/tales_sample/portada4.jpg',
      'assets/tales_sample/portada2.jpg',
      'assets/tales_sample/portada1.jpg',
    ];
  }

  List<String> getTitles() {
    return [
      'Tale 1',
      'Tale 2',
      'Tale 3',
      'Tale 4',
      'Tale 5',
      'Tale 6',
    ];
  }
}
