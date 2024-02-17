import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/shared/custom_appbar.dart';

class DetailsScreen extends StatelessWidget {
  final Widget widget;
  const DetailsScreen({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return _DetailsScreenSign(widget: widget);
  }
}

class _DetailsScreenSign extends StatelessWidget {
  final Widget widget;
  const _DetailsScreenSign({required this.widget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(leading: true),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
