import 'package:cuentos_pasantia/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'layers/application/providers/providers.dart';

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
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final user = ref.read(authUserProvider);
    final uid = user.asData?.value?.uid ?? "";
    if (uid.isNotEmpty) {
      ref.read(libraryContentProvider(uid).notifier).loadTales();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    debugPrint('state: ${state.name}');
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
