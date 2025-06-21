import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/app_theme.dart';
import 'package:untoggl_project/common/routes.dart';
import 'package:untoggl_project/common/services/local_services/preferences_service.dart';

class ThemeEncapsulator extends StatefulWidget {
  final String initialRoute;

  const ThemeEncapsulator({super.key, required this.initialRoute});

  @override
  State<ThemeEncapsulator> createState() => _ThemeEncapsulatorState();
}

class _ThemeEncapsulatorState extends State<ThemeEncapsulator> {
  ThemeMode _themeMode = ThemeMode.system;
  final _themeService = GetIt.instance.get<PreferencesService>();

  @override
  Widget build(BuildContext context) {
    _themeService.addListener(() {
      setState(() {
        _themeMode = _themeService.selectedTheme;
      });
    });
    return Container(
      color: _themeMode == ThemeMode.dark
          ? appThemeDark.scaffoldBackgroundColor
          : appThemeLight.scaffoldBackgroundColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWebLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return MaterialApp.router(
      title: 'UnToggl',
      routerConfig: routes,
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: _themeMode,
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return MaterialApp.router(
      title: 'UnToggl',
      routerConfig: webRoutes,
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: _themeMode,
    );
  }
}
