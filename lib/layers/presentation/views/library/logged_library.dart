import 'package:cuentos_pasantia/layers/presentation/views/home/library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

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

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(() {
    //   double maxScroll = _scrollController.position.maxScrollExtent;
    //   double currentScroll = _scrollController.position.pixels;
    //   double delta = MediaQuery.of(context).size.height * 0.25;

    //   if (maxScroll - currentScroll <= delta) {
    //     int actualLength = talesController.tales.length;
    //     ref
    //         .read(libraryContentProvider(widget.userId).notifier)
    //         .loadTales(page);
    //     if (actualLength != talesController.tales.length) {
    //       page++;
    //     } else {
    //       _scrollController.removeListener(() {});
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final actualState = ref.watch(libraryFilterProvider.notifier);
    final values = ref.read(libraryStateValuesProvider);
    final talesController =
        ref.watch(libraryContentProvider(widget.userId).notifier);
    talesController.loadTales(page);

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
            SegmentedButton(
              segments: [
                ButtonSegment(
                  value: UserTalesStatus.reading.name,
                  icon: Text(UserTalesStatus.reading.name),
                ),
                ButtonSegment(
                  value: UserTalesStatus.following.name,
                  icon: Text(UserTalesStatus.following.name),
                ),
                ButtonSegment(
                  value: UserTalesStatus.completed.name,
                  icon: Text(UserTalesStatus.completed.name),
                ),
              ],
              selected: {actualState.state.name},
              onSelectionChanged: (newSelected) {
                UserTalesStatus selected = updateSelectedValue(newSelected);
                actualState.update((state) => selected);
                setState(() {
                  debugPrint(actualState.state.name);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: talesController.tales.length,
                itemBuilder: (context, index) {
                  final userTale = talesController.tales[index];
                  return LibraryTale(
                    title: userTale.taleTitle,
                    chapter: 'Capítulo ${userTale.getLastChapterReaded}',
                    lastRead: userTale.timeSinceLastRead(),
                    urlImage: userTale.coverUrl,
                  );
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
}
