import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/tales/section.dart';
import '../../widgets/components/tales_grid/tales_grid.dart';

class TalesReaderScreen extends ConsumerStatefulWidget {
  const TalesReaderScreen({super.key});

  @override
  ConsumerState<TalesReaderScreen> createState() => _TalesReaderScreenState();
}

class _TalesReaderScreenState extends ConsumerState<TalesReaderScreen> {
  int chapter = 1;
  final ScrollController _scrollController = ScrollController();
  IconData icon = Icons.arrow_drop_down;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels - 100 >=
          (_scrollController.position.maxScrollExtent / 3)) {
        setState(() {
          icon = Icons.arrow_drop_up;
        });
      } else {
        setState(() {
          icon = Icons.arrow_drop_down;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sectionData = ref.watch(sectionDataProvider);
    AsyncValue<Section> sectionAsync = ref.watch(loadSectionProvider);
    // const String imageUrl =
    //     'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada3.jpg?alt=media&token=d7f743a3-59e3-434d-a220-fe08fc27b268';
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade100));
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const GridAppBar(
              isSearching: false,
              isPinned: false,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                  child: sectionAsync.when(data: (section) {
                return Column(
                  children: [
                    Text(
                      'Capítulo ${sectionData.chapter + 1}',
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      section.text,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }, error: (error, stack) {
                return Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
            ),
            SliverToBoxAdapter(
              child: sectionAsync.when(
                data: (section) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref
                              .read(sectionDataProvider.notifier)
                              .update((state) => state.copyWith(
                                    lastSectionId:
                                        section.options.first.getNext,
                                    actualPage: state.actualPage + 1,
                                  ));
                          setState(() {
                            sectionAsync =
                                ref.read(loadNextSectionProvider(sectionData));
                          });
                        },
                        style: buttonStyle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            section.options.first.text,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          debugPrint('Opcion B');
                        },
                        style: buttonStyle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(section.options.last.text,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16)),
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Icon(
                  icon,
                  size: 40,
                ),
              ),
            ),
            SliverFillRemaining(
              child: sectionAsync.when(
                data: (section) {
                  final url = section.getImageUrl;
                  if (url != null) {
                    return SizedBox(
                      height: 100,
                      child: Image.network(
                        section.getImageUrl!,
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                error: (error, stack) {
                  return const Center(
                    child: Text(
                      'Imagen no encontrada.',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
