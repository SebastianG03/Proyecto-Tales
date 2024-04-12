import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../config/router/app_routes.dart';
import '../../../application/providers/providers.dart';

class CustomAppBar extends StatelessWidget {
  final bool leading;

  const CustomAppBar({super.key, this.leading = false});

  @override
  Widget build(BuildContext context) {
    return (leading)
        ? const _CustomAppBarWithLeading()
        : const _CustomAppBarWithoutLeading();
  }
}

class _CustomAppBarWithLeading extends StatelessWidget {
  const _CustomAppBarWithLeading();

  @override
  Widget build(BuildContext context) {
    return PlatformAppBar(
      leading: PlatformIconButton(
        onPressed: () => context.pop(),
        cupertinoIcon: const Icon(CupertinoIcons.back),
        materialIcon: const Icon(Icons.arrow_back),
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "TaleTell",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBarWithoutLeading extends ConsumerWidget {
  const _CustomAppBarWithoutLeading();

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;

    return PlatformAppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "TaleTell",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailingActions: [
        IconButton(
          onPressed: () {
            final routes = ref.read(routerProvider);
            routes.router.pushNamed(AppRoutes.searchTaleView);
          },
          icon: Icon(Icons.search, color: colors.primary),
        ),
      ],
    );
  }
}
