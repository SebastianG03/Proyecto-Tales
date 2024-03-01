import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'firebase_options.dart';
import 'layers/domain/entities/tales/tales_exports.dart';
import 'layers/infrastructure/datasources/tales_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  // await dotenv.load();

  // MockData().mockData();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('AppLifecycleState: $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    final theme = ref.read(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tales Project',
      routerConfig: router.router,
      theme: theme,
    );
  }
}

class MockData {
  void mockData() async {
    final List<Tales> tales = await generateTestTales();
    final talesDatasource = TalesDataSource();

    for (Tales tale in tales) {
      Future.delayed(const Duration(seconds: 10), () {
        talesDatasource.uploadTale(tale);
      });
    }
    debugPrint('Mock data uploaded.');
  }

  Future<List<Tales>> generateTestTales() async {
    List<Tales> tales = [];
    int imageIndex = 1;

    for (int i = 1; i <= 40; i++) {
      String title = "Cuento de prueba $i";
      String abstract = '''
      Resumen del cuento de prueba $i.
      Fugiat est adipisicing et ut. Ullamco labore voluptate culpa aliquip sit irure incididunt
      deserunt ullamco irure do occaecat cillum. Eu duis nulla consectetur sit.
      Nisi veniam irure et eu excepteur aute incididunt incididunt consectetur occaecat qui nisi qui aute.
      Consectetur non ut irure amet nostrud excepteur. Pariatur proident aliquip dolor pariatur culpa dolor 
      aliqua id.
      Magna eu anim voluptate nulla eu dolore nulla cillum. Cupidatat laboris culpa proident aute voluptate
      proident voluptate anim. Velit minim nostrud in non nulla sint proident aute duis est culpa elit.
      Tempor et proident quis adipisicing labore incididunt magna nisi aute nisi aliqua commodo minim.
      Sit mollit amet ullamco elit duis dolor proident.
    ''';
      int ageLimit = Random().nextInt(16).clamp(12, 16);
      List<Gender> genders = [Gender.values[i % Gender.values.length]];
      if (imageIndex > 27) {
        imageIndex = 1;
      } else {
        imageIndex++;
      }

      String dir = (await getApplicationDocumentsDirectory()).path;
      File coverImage = File('$dir/portada$imageIndex.jpg');

      tales.add(Tales(
        title: title,
        abstract: abstract,
        coverImage: coverImage,
        ageLimit: ageLimit,
        genders: genders,
      ));
    }

    return tales;
  }
}
