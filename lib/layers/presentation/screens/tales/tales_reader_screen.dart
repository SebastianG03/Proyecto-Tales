import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/components/tales_grid/tales_grid.dart';
import 'package:cuentos_pasantia/config/router/app_routes.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom/custom_components.dart';

class TalesReaderScreen extends ConsumerStatefulWidget {
  const TalesReaderScreen({super.key});

  @override
  ConsumerState<TalesReaderScreen> createState() => _TalesReaderScreenState();
}

class _TalesReaderScreenState extends ConsumerState<TalesReaderScreen> {
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
    final sectionDataNotifier = ref.watch(sectionDataProvider.notifier);
    final sectionData = ref.watch(sectionDataProvider);
    final section =
        sectionDataNotifier.loadNextSection(ref.read(selectedOptionProvider));

    // const String imageUrl =
    //     'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada3.jpg?alt=media&token=d7f743a3-59e3-434d-a220-fe08fc27b268';
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade100));

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
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    ref
                        .read(selectedOptionProvider.notifier)
                        .update((state) => section.options.first.getNext);
                    debugPrint('Opcion A');
                    ref.read(routerProvider).router.pushReplacementNamed(
                        AppRoutes.readerView,
                        pathParameters: {
                          'taleId': ref.read(actualTaleProvider.notifier).state
                        });
                  },
                  style: buttonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      section.options.first.text,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(selectedOptionProvider.notifier)
                        .update((state) => section.options.last.getNext);
                    debugPrint('Opcion A');
                    ref.read(routerProvider).router.pushReplacementNamed(
                        AppRoutes.readerView,
                        pathParameters: {
                          'taleId': ref.read(actualTaleProvider.notifier).state
                        });
                  },
                  style: buttonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      section.options.last.text,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
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
              child: Visibility(
            visible:
                section.getImageUrl != null && section.getImageUrl!.isNotEmpty,
            replacement: const SizedBox(),
            child: SizedBox(
              height: 100,
              child:
                  section.getImageUrl != null && section.getImageUrl!.isNotEmpty
                      ? Image.network(
                          section.getImageUrl!,
                          fit: BoxFit.scaleDown,
                        )
                      : const SizedBox(),
            ),
          )),
        ],
      )),
    );
  }
}
