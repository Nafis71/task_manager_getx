import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_getx/utils/app_assets.dart';
import 'package:task_manager_getx/utils/app_routes.dart';
import 'package:task_manager_getx/viewModels/auth_view_model.dart';
import 'package:task_manager_getx/viewModels/user_view_model.dart';
import 'package:task_manager_getx/wrappers/svg_image_loader.dart';
import 'package:task_manager_getx/wrappers/widget_custom_animator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:get/get.dart';
import '../widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthViewModel _authViewModel;
  late final UserViewModel _userViewModel;
  @override
  void initState() {
    _authViewModel = Get.put(AuthViewModel());
    _userViewModel = Get.put(UserViewModel());
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      if (mounted) {
        bool status =
            await _authViewModel.authenticateToken(token);
        if (status && mounted) {
          await _userViewModel.loadUserData(preferences);
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
          });
        } else {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
          });
        }
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        childWidget: Center(
          child: WidgetCustomAnimator(
            incomingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(
                duration: const Duration(seconds: 2), scale: 0.3),
            childWidget: const SVGImageLoader(
              asset: AppAssets.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
