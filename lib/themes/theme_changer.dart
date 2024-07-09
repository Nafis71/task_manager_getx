import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/utils/app_assets.dart';
import 'package:task_manager_getx/utils/app_color.dart';

class ThemeChanger extends GetxController {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isAppLaunched = false;

  ThemeMode get themeMode => _themeMode;

  bool get isAppLaunched => _isAppLaunched;

  set setIsAppLaunched(bool isAppLaunched) {
    _isAppLaunched = isAppLaunched;
  }

  set setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    update();
  }

  set setThemeModeSilent(ThemeMode mode) {
    _themeMode = mode;
  }

  String getBackgroundImage(BuildContext context) {
    if (getThemeMode(context) == ThemeMode.dark) {
      return AppAssets.backgroundImageDark;
    }
    return AppAssets.backgroundImageLight;
  }

  ThemeMode getThemeMode(BuildContext context) {
    if (_themeMode == ThemeMode.system &&
        MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return ThemeMode.dark;
    }
    if (_themeMode == ThemeMode.dark) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  Color getContainerColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return AppColor.darkComponentsColor;
    }
    return Colors.white;
  }
}
