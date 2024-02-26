import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/views/home/home_views.dart';

import '../../layers/presentation/ui/screens/home/screens.dart';
import '../../layers/presentation/ui/views/login/login_views.dart';
import '../../layers/presentation/ui/views/tales/tales_views.dart';

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

  //Tales Sub Routes paths
  static const String _talesGridViewRoute = 'tales_grid_view/:tag';
  static const String _detailsTaleViewRoute = 'detail/:taleId';

  //Tales Sub Routes names
  static const String talesGridView = 'all_tales_by_tag';
  static const String taleDetails = 'tale_details';

  //Settings Sub Routes paths
  static const String _signInRoute = 'sign_in';
  static const String _registerRoute = 'register';

  //Settings Sub Routes names
  static const String signInView = 'sign_in';
  static const String registerView = 'register';

  // Navigator keys
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _rootTales =
      GlobalKey<NavigatorState>(debugLabel: 'shellTales');
  static final GlobalKey<NavigatorState> _rootLibrary =
      GlobalKey<NavigatorState>(debugLabel: 'shellLibrary');
  static final GlobalKey<NavigatorState> _rootSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

  final GoRouter router = GoRouter(
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
            //Branch tales
            StatefulShellBranch(navigatorKey: _rootTales, routes: [
              GoRoute(
                parentNavigatorKey: _rootTales,
                path: _talesRoute,
                name: talesView,
                builder: (context, state) => const TalesView(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootKey,
                    path: _talesGridViewRoute,
                    name: talesGridView,
                    builder: (context, state) => ChildScreen(
                      widget: TalesGridView(
                        tag: state.pathParameters['tag']!,
                      ),
                    ),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootKey,
                    path: _detailsTaleViewRoute,
                    name: taleDetails,
                    builder: (context, state) => TaleDetailsScreen(
                      widget: TaleDetailsView(
                          taleId: state.pathParameters['taleId']!),
                    ),
                  )
                ],
              )
            ]),

            //Branch library
            StatefulShellBranch(navigatorKey: _rootLibrary, routes: [
              GoRoute(
                path: _libraryRoute,
                name: libraryView,
                builder: (context, state) => const LibraryView(),
                routes: const [],
              )
            ]),

            //Branch settings
            StatefulShellBranch(navigatorKey: _rootSettings, routes: [
              GoRoute(
                path: _settingsRoute,
                name: settingsView,
                builder: (context, state) => const SettingsView(),
                routes: [
                  GoRoute(
                    path: _signInRoute,
                    name: signInView,
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) =>
                        const ChildScreen(widget: SignInView()),
                    routes: const [],
                  ),
                  GoRoute(
                    path: _registerRoute,
                    name: registerView,
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) =>
                        const ChildScreen(widget: RegisterView()),
                    routes: const [],
                  ),
                ],
              )
            ])
          ]),
    ],
  );
}
