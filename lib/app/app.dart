import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_getx/services/connectivity_checker.dart';
import 'package:task_manager_getx/themes/app_theme.dart';
import 'package:task_manager_getx/themes/theme_changer.dart';
import 'package:task_manager_getx/utils/app_routes.dart';
import 'package:task_manager_getx/utils/app_strings.dart';
import 'package:task_manager_getx/viewModels/auth_view_model.dart';
import 'package:task_manager_getx/viewModels/countdown_timer_view_model.dart';
import 'package:task_manager_getx/viewModels/dashboard_view_model.dart';
import 'package:task_manager_getx/viewModels/task_view_model.dart';
import 'package:task_manager_getx/viewModels/user_view_model.dart';

class TaskManager extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  final String userTheme;

  const TaskManager({super.key, required this.userTheme});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        onGenerateRoute: (routeSettings) {
          return AppRoutes.generateRoute(routeSettings);
        },
        theme: AppTheme.getLightTheme(),
        darkTheme: AppTheme.getDarkTheme(),
      );
    });
  }

  // void loadUserTheme(String theme, BuildContext context) {
  //   switch (theme) {
  //     case AppStrings.darkMode:
  //       context.read<ThemeChanger>().setThemeModeSilent = ThemeMode.dark;
  //
  //     case AppStrings.lightMode:
  //       context.read<ThemeChanger>().setThemeModeSilent = ThemeMode.light;
  //
  //     case AppStrings.systemMode:
  //       context.read<ThemeChanger>().setThemeModeSilent = ThemeMode.system;
  //   }
  // }
}
