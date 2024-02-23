import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/configurations.dart';

final routerProvider = StateProvider<AppRoutes>((ref) => AppRoutes());

final themeProvider = Provider<ThemeData>((ref) => AppTheme.lightTheme);
