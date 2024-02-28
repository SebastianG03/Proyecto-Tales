import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

import '../../../../aplication/providers/providers.dart';
import '../../../../domain/entities/user/users.dart';
import '../../widgets/shared/custom_appbar.dart';

class TalesView extends ConsumerStatefulWidget {
  const TalesView({super.key});

  @override
  ConsumerState<TalesView> createState() => _TalesViewState();
}

class _TalesViewState extends ConsumerState<TalesView> {
  @override
  @override
  void initState() {
    super.initState();
    ref.read(talesNotifierProvider.notifier).initTales();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(preferencesProvider.notifier).getUserData();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: <Widget>[
                TalesSlideshow(
                  tales: ref.watch(talesNotifierProvider).sliderTales,
                ),
                const SizedBox(
                  height: 20,
                ),
                HorizontalTalesListView(
                  tales: ref
                      .watch(talesNotifierProvider)
                      .recentTales
                      .take(8)
                      .toList(),
                  tag: 'Nuevos',
                ),
                HorizontalTalesListView(
                  tales: ref
                      .watch(talesNotifierProvider)
                      .ageLimitTales
                      .take(8)
                      .toList(),
                  tag: 'Para menores de 15',
                ),
                HorizontalTalesListView(
                  tales: ref
                      .watch(talesNotifierProvider)
                      .recentTales
                      .take(8)
                      .toList(),
                  tag: 'Varios',
                )
              ],
            );
          },
          childCount: 1,
        ))
      ],
    );
  }
}
