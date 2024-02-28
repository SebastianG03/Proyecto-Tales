import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/shared/custom_appbar.dart';

class ChildScreen extends StatelessWidget {
  final Widget widget;
  const ChildScreen({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: CustomAppBar(leading: true),
          ),
          resizeToAvoidBottomInset: false,
          body: widget),
    );
  }
}
