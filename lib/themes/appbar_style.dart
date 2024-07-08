import 'package:flutter/material.dart';
import 'package:task_manager_getx/utils/app_color.dart';

class AppbarStyle {
  static AppBarTheme getLightAppbarStyle() => const AppBarTheme(
      backgroundColor: AppColor.appBarBackgroundColorLight,
      foregroundColor: AppColor.appBarForegroundColor,
      surfaceTintColor: AppColor.appBarBackgroundColorLight,
      elevation: 0,
      actionsIconTheme: IconThemeData(size: 27));

  static AppBarTheme getDarkAppbarStyle() => getLightAppbarStyle()
      .copyWith(backgroundColor: AppColor.appBarBackgroundColorDark);
}
