import 'package:cuentos_pasantia/layers/presentation/views/loading/tales_initial_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/providers.dart';
import '../../../domain/entities/app/search/enums/enums.dart';
import '../../widgets/components/home/tales/tales_components.dart';
import '../../widgets/shared/custom_appbar.dart';

class TalesView extends ConsumerStatefulWidget {
  const TalesView({super.key});

  @override
  ConsumerState<TalesView> createState() => _TalesViewState();
}

class _TalesViewState extends ConsumerState<TalesView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final String uid = ref.read(authUserProvider).asData?.value?.uid ?? "";
    ref.read(sliderTalesProvider.notifier).loadTalesSliderTales();
    ref
        .read(premiumTalesProvider.notifier)
        .loadTalesByAccesibility(Accessibility.premium);
    ref
        .read(freeTalesProvider.notifier)
        .loadTalesByAccesibility(Accessibility.free);
    ref.read(kidsTalesProvider.notifier).loadTalesByAgeLimit(AgeLimit.forKids);
    ref
        .read(teensTalesProvider.notifier)
        .loadTalesByAgeLimit(AgeLimit.forTeens);
    if (uid.isNotEmpty) {
      ref.read(favoriteUsertalesProvider.notifier).loadUserTales(uid);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    super.activate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final slideTales = ref.watch(sliderTalesProvider);
    final premiumTales = ref.watch(premiumTalesProvider);
    final freeTales = ref.watch(freeTalesProvider);
    final kidsTales = ref.watch(kidsTalesProvider);
    final teensTales = ref.watch(teensTalesProvider);
    final favoriteTales =
        ref.watch(favoriteUsertalesProvider.notifier).favoriteTales;
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const TalesScreenLoader();

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
                  tales: slideTales,
                ),
                const SizedBox(
                  height: 20,
                ),
                FavoritesHorizontalListView(
                  usertales: favoriteTales,
                ),
                HorizontalTalesListView(
                  tales: kidsTales.take(8).toList(),
                  searchKey: SearchKeys.ageLimit,
                  tag: AgeLimit.forKids.name,
                ),
                HorizontalTalesListView(
                  tales: teensTales.take(8).toList(),
                  searchKey: SearchKeys.ageLimit,
                  tag: AgeLimit.forTeens.name,
                ),
                HorizontalTalesListView(
                  tales: premiumTales.take(8).toList(),
                  searchKey: SearchKeys.accesibility,
                  tag: Accessibility.premium.name,
                ),
                HorizontalTalesListView(
                  tales: freeTales.take(8).toList(),
                  searchKey: SearchKeys.accesibility,
                  tag: Accessibility.free.name,
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
