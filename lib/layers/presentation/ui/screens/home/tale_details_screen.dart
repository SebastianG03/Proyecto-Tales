import 'package:flutter/material.dart';

class TaleDetailsScreen extends StatelessWidget {
  final Widget widget;
  const TaleDetailsScreen({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: widget,
      ),
    );
  }
}
