import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/preferences/app_theme.dart';
import '../../../../config/router/app_routes.dart';

final routerProvider = StateProvider<AppRoutes>((ref) => AppRoutes());

final themeProvider = Provider<ThemeData>((ref) => AppTheme.lightTheme);
