import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/custom_components.dart';

class GridAppBar extends ConsumerWidget {
  final bool isSearching;
  final bool isPinned;
  const GridAppBar({super.key, required this.isSearching, this.isPinned = true});

  @override
  Widget build(BuildContext context, ref) {
    return SliverAppBar(
      elevation: 0,
      pinned: isPinned,
      stretch: true,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: SizedBox(),
      ),
      leading: PlatformIconButton(
        cupertinoIcon: const Icon(CupertinoIcons.back),
        materialIcon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: Visibility(
        visible: isSearching,
        child: const Padding(
            padding: EdgeInsets.only(left: 50, right: 10, bottom: 17, top: 10),
            child: CustomSearchBar()),
      ),
    );
  }
}
