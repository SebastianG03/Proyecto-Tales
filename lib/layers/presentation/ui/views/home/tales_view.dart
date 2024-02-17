import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/shared/custom_appbar.dart';

class TalesView extends ConsumerWidget {
  const TalesView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          CustomAppBar(leading: false),
          Text("Tales View"),
        ],
      ),
    );
  }
}
