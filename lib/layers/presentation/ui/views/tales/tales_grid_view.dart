import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/tales/tales_exports.dart';
import '../../widgets/components/tales_grid/tale_grid_slide.dart';

class TalesGridView extends ConsumerStatefulWidget {
  final List<Tales> tales;
  const TalesGridView({super.key, required this.tales});

  @override
  ConsumerState<TalesGridView> createState() => _TalesGridViewState();
}

class _TalesGridViewState extends ConsumerState<TalesGridView> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      sliver: SliverGrid.builder(
        itemCount: widget.tales.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, index) {
          return TaleGridSlide(
              imageUrl: widget.tales[index].getCoverUrl,
              title: widget.tales[index].title,
              premium: widget.tales[index].premium);
        },
      ),
    );
  }
}
