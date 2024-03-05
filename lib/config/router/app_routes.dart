import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/views/views.dart';
import '../../layers/presentation/ui/screens/screens.dart';

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
  static const String _talesGridViewRoute = 'view_tales';
  static const String _detailsTaleViewRoute = 'detail/:taleId';
  static const String _seachTaleViewRoute = 'search';
  static const String _readerRoute = 'read';

  //Tales Sub Routes names
  static const String talesGridView = 'all_tales_by_tag';
  static const String taleDetails = 'tale_details';
  static const String searchTaleView = 'search_tale';
  static const String readerView = 'reader_tale';

  //Settings Sub Routes paths
  static const String _accountRoute = 'account';
  static const String _updateAccountRoute = 'update_user';

  //Settings Sub Routes names
  static const String accountView = 'account';
  static const String updateAccountView = 'update_user';

  //Account Sub Routes paths
  static const String _signInRoute = 'sign_in';
  static const String _registerRoute = 'register';

  //Account Sub Routes names
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
          //Main wrapper,
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
                    builder: (context, state) => const TalesGridScreen(
                      isSearching: false,
                    ),
                    routes: const [],
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootKey,
                    path: _seachTaleViewRoute,
                    name: searchTaleView,
                    builder: (context, state) => const TalesGridScreen(
                      isSearching: true,
                    ),
                    routes: const [],
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootKey,
                    path: _detailsTaleViewRoute,
                    name: taleDetails,
                    builder: (context, state) => TaleDetailsScreen(
                      taleId: state.pathParameters['taleId']!,
                    ),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootKey,
                        path: _readerRoute,
                        name: readerView,
                        builder: (context, state) => const TalesReaderScreen(),
                        routes: const [],
                      ),
                    ],
                  ),
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
                    path: _accountRoute,
                    name: accountView,
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) => const ChildScreen(
                      widget: AccountView(),
                    ),
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
                      GoRoute(
                        path: _updateAccountRoute,
                        name: updateAccountView,
                        parentNavigatorKey: _rootKey,
                        builder: (context, state) {
                          return const ChildScreen(
                            widget: UpdateUserView(),
                          );
                        },
                        routes: const [],
                      )
                    ],
                  ),
                ],
              )
            ])
          ]),
    ],
  );
}
