import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorizontalSlideTitle extends ConsumerWidget {
  final String tag;
  final void Function()? onTap;
  final double? height;
  const HorizontalSlideTitle(
      {super.key, required this.tag, this.onTap, this.height});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height ?? 50.0,
      child: Row(children: [
        Text(tag, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Visibility(
          visible: onTap != null,
          child: IconButton(
            onPressed: () {
              if (onTap != null) onTap!();
            },
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 20,
          ),
        )
      ]),
    );
  }
}
