import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatelessWidget {
  final ValueChanged<int> onTapped;
  final int activeIndex;
  final StatefulNavigationShell navigationShell;

  BottomNavBar({
    super.key,
    this.activeIndex = 0,
    required this.navigationShell,
    required this.onTapped,
  });

  final List<IconData> icons = [
    LineIcons.home, //Principal page
    LineIcons.book, //Library page
    LineIcons.cog, //User options
  ];
  final List<String> titles = [
    'Cuentos',
    'Librería',
    'Opciones',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        for (int i = 0; i < icons.length; i++)
          BottomNavigationBarItem(
            icon: Icon(icons[i]),
            activeIcon: Icon(icons[i]), // Add activeIcon property
            label: titles[i],
          ),
      ],
      currentIndex: activeIndex,
      onTap: onTapped,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      showUnselectedLabels: false,
      showSelectedLabels: true,
    );
  }
}
