import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/models/responseModel/failure.dart';
import 'package:task_manager_getx/utils/app_color.dart';
import 'package:task_manager_getx/utils/app_navigation.dart';
import 'package:task_manager_getx/utils/app_routes.dart';
import 'package:task_manager_getx/utils/app_strings.dart';
import 'package:task_manager_getx/viewModels/auth_view_model.dart';
import 'package:task_manager_getx/viewModels/task_view_model.dart';
import 'package:task_manager_getx/viewModels/user_view_model.dart';
import 'package:task_manager_getx/views/authScreens/signInScreen/sign_in_screen_form.dart';
import 'package:task_manager_getx/views/widgets/app_snackbar.dart';

import '../../widgets/background_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailTEController;
  late final TextEditingController _passwordTEController;
  late final GlobalKey<FormState> _formKey;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _emailTEController = TextEditingController();
    _passwordTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return BackgroundWidget(
            childWidget: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: (orientation == Orientation.portrait)
                        ? screenHeight * 0.25
                        : screenHeight * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.signInHeaderText,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Gap(20),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: SignInScreenForm(
                        emailTEController: _emailTEController,
                        passwordTEController: _passwordTEController,
                        formKey: _formKey,
                        emailFocusNode: _emailFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        screenWidth: screenWidth,
                        initiateSignIn: initiateSignIn,
                      ),
                    ),
                    const Gap(50),
                    Center(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.emailVerificationScreen),
                        child: Text(
                          AppStrings.forgetPasswordText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.signInBottomTextOne,
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: AppStrings.signInBottomTextTwo,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => AppNavigation().gotoSignUp(
                                    _emailFocusNode, _passwordFocusNode),
                              style: const TextStyle(
                                color: AppColor.appPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> initiateSignIn() async {
    bool status = await Get.find<AuthViewModel>().signInUser(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
        userViewModel: Get.find<UserViewModel>());
    if (mounted && status) {
      Get.find<TaskViewModel>().resetTaskData();
      Get.offAndToNamed(AppRoutes.dashboardScreen);
      Get.find<AuthViewModel>().setPasswordObscure = true;
      return;
    }
    if (mounted) {
      Failure failure = Get.find<AuthViewModel>().response as Failure;
      AppSnackBar().showSnackBar(
          title: AppStrings.signInFailureTitle,
          content: failure.message,
          contentType: ContentType.failure,
          color: AppColor.snackBarFailureColor,
          context: context);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
