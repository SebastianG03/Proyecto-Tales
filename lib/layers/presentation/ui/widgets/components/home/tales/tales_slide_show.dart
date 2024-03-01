import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/configurations.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/home/tales/tales_components.dart';

import '../../../../../../domain/entities/tales/tales_exports.dart';

class TalesSlideshow extends ConsumerStatefulWidget {
  final List<Tales> tales;
  const TalesSlideshow({super.key, required this.tales});

  @override
  ConsumerState<TalesSlideshow> createState() => _TalesSlideshowState();
}

class _TalesSlideshowState extends ConsumerState<TalesSlideshow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Swiper(
            itemCount: widget.tales.length,
            itemWidth: 300,
            duration: 1000,
            scale: 0.9,
            layout: SwiperLayout.STACK,
            pagination: const SwiperPagination(
              margin: EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.blue,
              ),
            ),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () => ref.read(routerProvider).router.goNamed(
                      AppRoutes.taleDetails,
                      pathParameters: {'taleId': widget.tales[index].id}),
                  child: SwiperSlide(
                    imageUrl: widget.tales[index].getCoverUrl,
                    title: widget.tales[index].title,
                  ),
                )),
      ),
    );
  }
}
