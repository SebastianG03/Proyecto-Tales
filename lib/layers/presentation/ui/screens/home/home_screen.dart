import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/shared/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: widget.navigationShell,
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavBar(
        activeIndex: activeIndex,
        navigationShell: widget.navigationShell,
        onTapped: _onTapped,
      ),
    );
  }

  void _onTapped(int index) {
    //Update index
    setState(() {
      activeIndex = index;
      if (kDebugMode) {
        print("Active index: $activeIndex | Index Selected: $index");
      }
    });

    //Navigation
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
