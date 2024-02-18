import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

class TalesSlideshow extends StatelessWidget {
  final List<String> imageUrl;
  final List<String> title;
  const TalesSlideshow(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Swiper(
            itemCount: title.length,
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
            itemBuilder: (context, index) => SwiperSlide(
                  imageUrl: imageUrl[index],
                  title: title[index],
                )),
      ),
    );
  }
}
