import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app.dart';
import '../viewModels/auth_view_model.dart';
import 'app_routes.dart';

class AppNavigation extends AuthViewModel {
  static AppNavigation? _instance;

  AppNavigation._();

  factory AppNavigation() {
    //singleton pattern
    _instance ??= AppNavigation._();
    return _instance!;
  }

  void gotoSignIn() {
    setPasswordObscure = true;
    Get.back();
  }

  void gotoSignUp(FocusNode emailFocusNode, FocusNode passwordFocusNode) {
    setPasswordObscure = true;
    Get.toNamed(AppRoutes.signUpScreen)?.then((value){
      emailFocusNode.unfocus();
      passwordFocusNode.unfocus();
    });
  }

  Future<void> signOutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offNamed(AppRoutes.signInScreen);
  }
}
