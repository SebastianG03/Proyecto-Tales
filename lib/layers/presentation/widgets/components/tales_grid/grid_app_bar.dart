import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GridAppBar extends ConsumerWidget {
  final bool isSearching;
  final bool isPinned;
  final VoidCallback? onPressed;
  const GridAppBar(
      {super.key,
      required this.isSearching,
      this.isPinned = true,
      this.onPressed});

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
        onPressed: () => (onPressed == null) ? context.pop() : onPressed,
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
