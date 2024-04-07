import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels - 100 >=
    //       (_scrollController.position.maxScrollExtent / 3)) {
    //     setState(() {
    //       icon = Icons.arrow_drop_up;
    //     });
    //   } else {
    //     setState(() {
    //       icon = Icons.arrow_drop_down;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final sectionDataNotifier = ref.watch(sectionDataProvider.notifier);
    final sectionData = ref.watch(sectionDataProvider);
    final section =
        sectionDataNotifier.loadNextSection(ref.read(selectedOptionProvider));

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
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
              onPressed: () => context.pop(),
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
                    height: 20,
                  ),
                  Text(
                    section.text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
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

                          ref
                              .read(selectedOptionProvider.notifier)
                              .update((state) => option.getNext);
                          debugPrint(option.id);
                          ref.read(routerProvider).router.pushReplacementNamed(
                              AppRoutes.readerView,
                              pathParameters: {
                                'taleId':
                                    ref.read(actualTaleProvider.notifier).state
                              });
                        },
                        label: option.text,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Visibility(
                visible: section.getImageUrl != null &&
                    section.getImageUrl!.isNotEmpty,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: section.getImageUrl != null &&
                          section.getImageUrl!.isNotEmpty
                      ? Image.network(
                          section.getImageUrl!,
                          fit: BoxFit.scaleDown,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
          // SliverFillRemaining(
          //     child: Visibility(
          //   visible:
          //       section.getImageUrl != null && section.getImageUrl!.isNotEmpty,
          //   replacement: const SizedBox(),
          //   child: SizedBox(
          //     height: 100,
          //     child:
          //         section.getImageUrl != null && section.getImageUrl!.isNotEmpty
          //             ? Image.network(
          //                 section.getImageUrl!,
          //                 fit: BoxFit.scaleDown,
          //               )
          //             : const SizedBox(),
          //   ),
          // )),
        ],
      )),
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
