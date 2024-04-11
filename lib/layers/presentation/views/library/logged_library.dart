import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../../domain/entities/user/users.dart';
import '../../widgets/components/home/library/library_tales.dart';

class LoggedLibrary extends ConsumerStatefulWidget {
  final String userId;
  const LoggedLibrary({super.key, required this.userId});

  @override
  ConsumerState<LoggedLibrary> createState() => _LoggedLibraryState();
}

class _LoggedLibraryState extends ConsumerState<LoggedLibrary> {
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  late LibraryNotifier talesController;
  bool isLoading = false;
  final List<UserTales> userTales = [];

  @override
  void initState() {
    super.initState();
    talesController = ref.read(libraryContentProvider(widget.userId).notifier);

    Future.delayed(const Duration(milliseconds: 100), () async {
      isLoading = true;
      await talesController.loadTales();
      final List<UserTales> changedTales =
          talesController.actualStatus(UserTalesStatus.reading);
      userTales.clear();
      updateList(changedTales);
      isLoading = false;
      setState(() {});
    });
    debugPrint(
        'Controller list lengt: ${talesController.tales.length} | local list length ${userTales.length}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Tales length in controller ${talesController.tales.length}');
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
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeAlign: 3.0,
                      ),
                    );
                  } else if (userTales.isEmpty) {
                    return const Center(
                        child: Text('No hay cuentos en esta sección'));
                  } else {
                    return LibraryTale(
                      title: userTales[index].taleTitle,
                      chapter:
                          'Capítulo ${userTales[index].getLastChapterReaded + 1}',
                      lastRead: userTales[index].timeSinceLastRead(),
                      urlImage: userTales[index].coverUrl,
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

  UserTalesStatus updateSelectedValue(Set<Object> newSelected) {
    if (newSelected.first == UserTalesStatus.reading.name) {
      return UserTalesStatus.reading;
    } else if (newSelected.first == UserTalesStatus.completed.name) {
      return UserTalesStatus.completed;
    } else {
      return UserTalesStatus.following;
    }
  }

  void updateList(List<UserTales> listChanged) {
    userTales.clear();
    userTales.addAll(listChanged);
    debugPrint('Changed list length: ${listChanged.length}');
    debugPrint('UserTales length: ${userTales.length}');
    userTales.forEach((element) => debugPrint(element.taleId));
    setState(() {});
  }
}
