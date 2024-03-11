import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.black54;
    return PlatformSearchBar(
      hintText: 'Buscar',
      hintStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
      focusNode: FocusNode(),
      backgroundColor: Colors.grey.shade100,
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      onTap: () {},
      cupertino: (context, platform) => CupertinoSearchBarData(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onSubmitted: (value) {},
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: iconColor,
        ),
      ),
      material: (context, platform) => MaterialSearchBarData(
        elevation: MaterialStateProperty.all(0.5),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
        side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(color: Colors.black, width: 0.5)),
        onSubmitted: (value) {},
        leading: Icon(
          Icons.search,
          color: iconColor,
        ),
      ),
      onChanged: (value) {},
    );
  }
}
