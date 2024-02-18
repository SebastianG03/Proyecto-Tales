import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/screens/home/details_screen.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/screens/home/home_screen.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/views/home/home_views.dart';

import '../../layers/presentation/ui/views/login/login_views.dart';

class AppRoutes {
  AppRoutes();

  //Initial route

  //Home Routes paths
  static const String _talesRoute = '/tales';
  static const String _libraryRoute = '/library';
  static const String _settingsRoute = '/settings';

  //Routes names
  //Estas rutas pertenecen a las vistas del menú principal
  static const String talesView = 'tales';
  static const String libraryView = 'library';
  static const String settingsView = 'settings';

  //Settings Sub Routes paths
  static const String _signInRoute = 'sign_in';
  static const String _registerRoute = 'register';

  //Settings Sub Routes names
  static const String signInView = 'sign_in';
  static const String registerView = 'register';

  //Principal Sub Routes names

  // Navigator keys
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _rootHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final GlobalKey<NavigatorState> _rootLibrary =
      GlobalKey<NavigatorState>(debugLabel: 'shellLibrary');
  static final GlobalKey<NavigatorState> _rootSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

  static final GoRouter router = GoRouter(
    initialLocation: _talesRoute,
    navigatorKey: _rootKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          //Main wrapper
          builder: (context, state, navigationShell) => HomeScreen(
                navigationShell: navigationShell,
              ),
          branches: <StatefulShellBranch>[
            //Vistas del la pantalla principal que contienen el bottom navbar
            //Branch tale
            StatefulShellBranch(navigatorKey: _rootHome, routes: [
              GoRoute(
                path: _talesRoute,
                name: talesView,
                builder: (context, state) => const TalesView(),
                routes: const [],
              )
            ]),

            //Branch library
            StatefulShellBranch(navigatorKey: _rootLibrary, routes: [
              GoRoute(
                path: _libraryRoute,
                name: libraryView,
                builder: (context, state) => const LibraryView(id: 0),
                routes: const [],
              )
            ]),

            //Branch settings
            StatefulShellBranch(navigatorKey: _rootSettings, routes: [
              GoRoute(
                path: _settingsRoute,
                name: settingsView,
                builder: (context, state) => const SettingsView(id: 0),
                routes: [
                  GoRoute(
                    path: _signInRoute,
                    name: signInView,
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) =>
                        const DetailsScreen(widget: SignInView()),
                    routes: const [],
                  ),
                  GoRoute(
                    path: _registerRoute,
                    name: registerView,
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) =>
                        const DetailsScreen(widget: RegisterView()),
                    routes: const [],
                  ),
                ],
              )
            ])
          ]),
    ],
  );
}
