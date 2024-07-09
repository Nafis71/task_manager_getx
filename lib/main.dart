import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_getx/app/app.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/themes/theme_changer.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? theme = preferences.getString("themeMode");
  theme ??= "system";
  Get.put(ThemeChanger());
  runApp(
    DevicePreview(
      builder: (_) => TaskManager(
        userTheme: theme!,
      ),
    ),
  );
}
