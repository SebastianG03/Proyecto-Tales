import 'package:flutter/material.dart';

class TalesGridLoader extends StatelessWidget {
  const TalesGridLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 180,
      ),
      itemBuilder: (context, index) {
        return const SkeletonFrame();
      },
    );
  }
}

class SkeletonFrame extends StatefulWidget {
  const SkeletonFrame({super.key});

  @override
  State<SkeletonFrame> createState() => _SkeletonFrameState();
}

class _SkeletonFrameState extends State<SkeletonFrame>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);

    animation.addStatusListener((status) async {
      if (status  == AnimationStatus.completed) {
        await Future.delayed(const Duration(microseconds: 600));
        controller.reverse();
        await Future.delayed(const Duration(microseconds: 400));
      } else if (status == AnimationStatus.dismissed) {
        await Future.delayed(const Duration(microseconds: 400));
        controller.forward();
        await Future.delayed(const Duration(microseconds: 600));
      }
    });

//this will start the animation
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundShadow(),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          decoration: decoration(),
          height: 120,
          width: double.infinity,
        ),
      ),
    );
  }

  BoxDecoration backgroundShadow() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 3,
          offset: Offset(0, 0),
        )
      ],
    );
  }

  BoxDecoration decoration() {
    return const BoxDecoration(
      color: Color.fromARGB(213, 129, 129, 129),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }
}
