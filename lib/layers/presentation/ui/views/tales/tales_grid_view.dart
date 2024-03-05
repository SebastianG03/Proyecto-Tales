import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/components/tales_grid/tale_grid_slide.dart';

class TalesGridView extends ConsumerWidget {
  final int itemCount;
  const TalesGridView({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      sliver: SliverGrid.builder(
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, index) {
          String imageUrl =
              'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada27.jpg?alt=media&token=48ca17c4-bc11-4b00-b537-b9cc53e41a48';
          String title = 'Tale $index';
          bool premium = index.isEven;
          return TaleGridSlide(
              imageUrl: imageUrl, title: title, premium: premium);
        },
      ),
    );
  }
}
