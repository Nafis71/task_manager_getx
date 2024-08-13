import 'package:get/get.dart';
import 'package:task_manager_getx/services/connectivity_checker.dart';
import 'package:task_manager_getx/viewModels/auth_view_model.dart';
import 'package:task_manager_getx/viewModels/countdown_timer_view_model.dart';
import 'package:task_manager_getx/viewModels/dashboard_view_model.dart';
import 'package:task_manager_getx/viewModels/task_view_model.dart';
import 'package:task_manager_getx/viewModels/user_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskViewModel());
    Get.put(AuthViewModel());
    Get.put(CountdownTimerViewModel());
    Get.put(DashboardViewModel());
    Get.put(UserViewModel());
    Get.put(ConnectivityChecker());
  }
}
