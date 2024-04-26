import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/home/library/library_tales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsertalesListView extends ConsumerWidget {
  final ScrollController _scrollController;
  final List<UserTales> userTales;
  final void Function()? onTap;

  const UsertalesListView({
    super.key,
    required ScrollController scrollController,
    required this.userTales,
    this.onTap,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context, ref) {
    if (userTales.isEmpty) {
      return const Center(child: Text('No hay cuentos en esta sección'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: userTales.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ref
                .read(actualTaleProvider.notifier)
                .update((state) => userTales[index].taleId);

            ref.read(routerProvider).router.goNamed(AppRoutes.taleDetails,
                pathParameters: {'taleId': userTales[index].taleId});
            if (onTap != null) {
              onTap!();
            }
          },
          child: LibraryTale(
            title: userTales[index].taleTitle,
            chapter: 'Capítulo ${userTales[index].getLastChapterReaded + 1}',
            lastRead: userTales[index].timeSinceLastRead(),
            urlImage: userTales[index].coverUrl,
          ),
        );
      },
    );
  }
}
