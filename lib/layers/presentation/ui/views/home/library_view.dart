import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/home/library/library_tales.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(authUserProvider);

    return userStream.when(data: (user) {
      if (user != null) {
      final userModel = ref.watch(preferencesProvider).user;
        return LoggedLibrary(user: userModel!);
      } else {
        return const LogOutLibrary();
      }
    }, error: (error, stack) {
      return const Text('Error al cargar el usuario');
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class LogOutLibrary extends StatelessWidget {
  const LogOutLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Mis cuentos',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Inicie sesión para acceder a su biblioteca o cree una cuenta para empezar su colección.",
            maxLines: 3,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            width: 250,
            child: Image(
                image: AssetImage('assets/library_img/library_img1.png'),
                fit: BoxFit.cover,
                width: 250),
          ),
        ],
      ),
    ));
  }
}

class LoggedLibrary extends StatelessWidget {
  final UserModel user;
  const LoggedLibrary({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Mis cuentos',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SegmentedButton(
              segments: const [
                ButtonSegment(value: 'Reading', icon: Text('Leyendo')),
                ButtonSegment(value: 'Completed', icon: Text('Completado'))
              ],
              selected: const {'Reading'},
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: getItems().length,
                itemBuilder: (context, index) => getItems()[index],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getItems() {
    return const [
      LibraryTale(
          title: 'Tale 1',
          chapter: 'Capítulo 1',
          lastRead: 4,
          urlImage: 'assets/tales_sample/portada1.jpg'),
      LibraryTale(
          title: 'Tale 2',
          chapter: 'Capítulo 4',
          lastRead: 156,
          urlImage: 'assets/tales_sample/portada2.jpg'),
      LibraryTale(
          title: 'Tale 3',
          chapter: 'Capítulo 2',
          lastRead: 6,
          urlImage: 'assets/tales_sample/portada3.jpg'),
      LibraryTale(
          title: 'Tale 4',
          chapter: 'Capítulo 10',
          lastRead: 3,
          urlImage: 'assets/tales_sample/portada4.jpg'),
      LibraryTale(
          title: 'Tale 10',
          chapter: 'Capítulo 2',
          lastRead: 43,
          urlImage: 'assets/tales_sample/portada2.jpg'),
      LibraryTale(
          title: 'Tale 11',
          chapter: 'Capítulo 5',
          lastRead: 102,
          urlImage: 'assets/tales_sample/portada1.jpg'),
    ];
  }
}
