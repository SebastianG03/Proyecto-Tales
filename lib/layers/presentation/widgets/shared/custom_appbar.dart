import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/application/delegates/search_tale_delegate.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../application/providers/providers.dart';

class CustomAppBar extends StatelessWidget {
  final bool leading;
  final String? title;

  const CustomAppBar({super.key, this.leading = false, this.title});

  @override
  Widget build(BuildContext context) {
    return (leading)
        ? _CustomAppBarWithLeading(
            title: title,
          )
        : const _CustomAppBarWithoutLeading();
  }
}

class _CustomAppBarWithLeading extends StatelessWidget {
  final String? title;
  const _CustomAppBarWithLeading({this.title});

  @override
  Widget build(BuildContext context) {
    return PlatformAppBar(
      leading: PlatformIconButton(
        onPressed: () => context.pop(),
        cupertinoIcon: const Icon(CupertinoIcons.back),
        materialIcon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title ?? "TaleTell",
            style: const TextStyle(
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

class _CustomAppBarWithoutLeading extends ConsumerStatefulWidget {
  const _CustomAppBarWithoutLeading();

  @override
  ConsumerState<_CustomAppBarWithoutLeading> createState() =>
      _CustomAppBarWithoutLeadingState();
}

class _CustomAppBarWithoutLeadingState
    extends ConsumerState<_CustomAppBarWithoutLeading> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return PlatformAppBar(
      title: const Text(
        "Cuentos interactivos",
        style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
      ),
      trailingActions: [
        IconButton(
          onPressed: () async {
            final searchQuery = ref.read(searchQueryProvider);

            final tale = await showSearch<Tales?>(
                context: context,
                query: searchQuery,
                delegate: SearchTaleDelegate(
                  searchTales:
                      ref.read(searchTalesProvider.notifier).searchTalesByQuery,
                ));

            if (tale != null) {
              ref.read(actualTaleProvider.notifier).update((state) => tale.id);

              ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
                  pathParameters: {'taleId': tale.id});
            }
          },
          icon: Icon(Icons.search, color: colors.primary),
        ),
      ],
    );
  }
}
