import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../widgets/components/home/library/library_tales.dart';

class LoggedLibrary extends ConsumerStatefulWidget {
  final String userId;
  const LoggedLibrary({super.key, required this.userId});

  @override
  ConsumerState<LoggedLibrary> createState() => _LoggedLibraryState();
}

class _LoggedLibraryState extends ConsumerState<LoggedLibrary> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(favoriteUsertalesProvider.notifier).loadUserTales(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final userTales = ref.watch(favoriteUsertalesProvider.notifier).usertales;
    // final actualState = ref.watch(libraryFilterProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Mis cuentos',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: userTales.length,
                itemBuilder: (context, index) {
                  if (userTales.isEmpty) {
                    return const Center(
                        child: Text('No hay cuentos en esta sección'));
                  } else {
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(actualTaleProvider.notifier)
                            .update((state) => userTales[index].taleId);

                        ref
                            .read(routerProvider)
                            .router
                            .goNamed(AppRoutes.taleDetails, pathParameters: {
                          'taleId': userTales[index].taleId
                        });
                      },
                      child: LibraryTale(
                        title: userTales[index].taleTitle,
                        chapter:
                            'Capítulo ${userTales[index].getLastChapterReaded + 1}',
                        lastRead: userTales[index].timeSinceLastRead(),
                        urlImage: userTales[index].coverUrl,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
