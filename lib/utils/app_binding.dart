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
    Get.lazyPut(()=> TaskViewModel());
    Get.lazyPut(()=>AuthViewModel());
    Get.lazyPut(()=>CountdownTimerViewModel());
    Get.lazyPut(()=>DashboardViewModel());
    Get.lazyPut(()=>UserViewModel());
    Get.lazyPut(()=>ConnectivityChecker());
  }
}
