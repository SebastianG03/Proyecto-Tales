import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class SettingsView extends ConsumerWidget {
  final int id;
  const SettingsView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> items = ['Iniciar Sesión', 'Crear Cuenta', 'Ajustes'];
    List<IconData> icons = [
      LineIcons.alternateSignIn,
      LineIcons.userPlus,
      LineIcons.cog
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: UserCard(),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(icons[index]),
                  title: Text(items[index]),
                  onTap: () {},
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green,
              child: Text('G', style: TextStyle(fontSize: 25)),
            ),
            SizedBox(
              width: 30,
            ),
            Text('Guest', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
