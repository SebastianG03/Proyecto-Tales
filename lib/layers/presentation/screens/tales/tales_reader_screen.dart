import 'package:cuentos_pasantia/layers/domain/entities/tales/options.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../config/helpers/string_format.dart';

class TalesReaderScreen extends ConsumerStatefulWidget {
  const TalesReaderScreen({super.key});

  @override
  ConsumerState<TalesReaderScreen> createState() => _TalesReaderScreenState();
}

class _TalesReaderScreenState extends ConsumerState<TalesReaderScreen> {
  final ScrollController _scrollController = ScrollController();
  // IconData icon = Icons.arrow_drop_down;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sectionDataNotifier = ref.watch(sectionDataProvider.notifier);
    final sectionData = ref.watch(sectionDataProvider);
    final section =
        sectionDataNotifier.loadNextSection(ref.read(selectedOptionProvider));

    return SafeArea(
      child: Scaffold(
          body: Scrollbar(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: false,
              floating: true,
              stretch: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: SizedBox(),
              ),
              leading: PlatformIconButton(
                cupertinoIcon: const Icon(CupertinoIcons.back),
                materialIcon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      sectionData.chapterTitle,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      StringFormat.formatText(section.text),
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: section.options
                    .map(
                      (option) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextButton(
                          onPressed: () {
                            final nextChapter = sectionData.chapter + 1;

                            //Comprueba si hay mas capitulos, si no hay carga el siguiente capitulo
                            if (option.getNext.isEmpty) {
                              if (nextChapter < sectionData.numberOfChapters) {
                                sectionDataNotifier.initData(
                                    ref.read(actualTaleProvider.notifier).state,
                                    nextChapter);
                              } else {
                                CustomSnackbar.showSnackBar(
                                    context, "No hay más capítulos.");
                                return;
                              }
                            }

                            _loadNextSection(option, sectionData);
                          },
                          label: option.text,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Visibility(
                  visible: section.getImageUrl != null &&
                      section.getImageUrl!.isNotEmpty,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: section.getImageUrl != null &&
                            section.getImageUrl!.isNotEmpty
                        ? CustomNetworkImage(
                            url: section.getImageUrl!, boxFit: BoxFit.scaleDown)
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _loadNextSection(Options option, SectionData sectionData) {
    ref.read(selectedOptionProvider.notifier).update((state) => option.getNext);
    debugPrint(option.id);

    //Actualiza el registro del usuario
    _onClosed(
        sectionData.taleId, sectionData.chapter, sectionData.lastSectionId);

    ref.read(routerProvider).router.pushReplacementNamed(AppRoutes.readerView,
        pathParameters: {
          'taleId': ref.read(actualTaleProvider.notifier).state
        });
  }

  void _onClosed(
      String taleId, int lastChapterReaded, String lastSectionReaded) {
    final userTalesController = ref.read(libraryManagementProvider.notifier);
    final uid = ref.read(authRepositoryProvider).getActualUserId();

    userTalesController.updateTale(
      userId: uid,
      taleId: taleId,
      lastChapterReaded: lastChapterReaded,
      lastSectionReaded: lastSectionReaded,
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const CustomTextButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade100));

    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: buttonStyle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
