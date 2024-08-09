import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/utils/app_color.dart';
import 'package:task_manager_getx/utils/app_strings.dart';
import 'package:task_manager_getx/viewModels/auth_view_model.dart';
import 'package:task_manager_getx/viewModels/countdown_timer_view_model.dart';
import 'package:task_manager_getx/views/authScreens/forgetPasswordScreen/pinVerificationScreen/pin_verification_form.dart';
import 'package:task_manager_getx/views/authScreens/forgetPasswordScreen/pinVerificationScreen/resend_pin_layout.dart';
import 'package:task_manager_getx/views/widgets/app_snackbar.dart';
import 'package:task_manager_getx/views/widgets/forget_password_layout.dart';

import '../../../../utils/app_routes.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  late final List<TextEditingController> pinTEControllers;
  late final List<FocusNode> focusNodes;
  late GlobalKey<FormState> _formKey;
  final double textFieldHeight = 50;
  late Timer timer;

  @override
  void initState() {
    pinTEControllers = List.generate(6, (index) => TextEditingController());
    focusNodes = List.generate(6, (index) => FocusNode());
    _formKey = GlobalKey<FormState>();
    super.initState();
    startCountDownTimer();
  }

  void startCountDownTimer() async {
    Get.find<CountdownTimerViewModel>().resetCountDown();
    timer = Timer.periodic(const Duration(seconds: 1), (countdown) {
      if (countdown.tick > 60) {
        countdown.cancel();
        return;
      }
      Get.find<CountdownTimerViewModel>().updateCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return ForgetPasswordLayout(
            orientation: orientation,
            horizontalMargin: screenWidth * 0.1,
            verticalMargin: (orientation == Orientation.portrait)
                ? screenHeight * 0.25
                : screenHeight * 0.15,
            headerText: AppStrings.pinVerificationHeaderText,
            bodyText: AppStrings.pinVerificationBodyText,
            screenWidth: screenWidth,
            buttonWidget: const Text(
              AppStrings.pinVerificationButtonText,
            ),
            onButtonPressed: (value) {
              if (_formKey.currentState!.validate()) {
                initiatePinVerification();
                return;
              }
              AppSnackBar().showSnackBar(
                  title: AppStrings.emptyPinVerificationFieldTitle,
                  content: AppStrings.emptyPinVerificationFieldMessage,
                  contentType: ContentType.warning,
                  color: AppColor.snackBarWarningColor,
                  context: context);
            },
            child: Column(
              children: [
                PinVerificationForm(
                  formKey: _formKey,
                  textFieldWidth: (orientation == Orientation.portrait)
                      ? screenWidth * 0.11
                      : screenWidth * 0.09,
                  pinTEControllers: pinTEControllers,
                  focusNodes: focusNodes,
                ),
                const Gap(5),
                GetBuilder<CountdownTimerViewModel>(
                  builder: (viewModel) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ResendPinLayout(
                      resendTimeLeft: viewModel.resendTimeLeft,
                      email: Get.find<AuthViewModel>().recoveryEmail,
                      restartTimer: startCountDownTimer,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> initiatePinVerification() async {
    String otp = "";
    for (TextEditingController controller in pinTEControllers) {
      otp = otp + controller.text.trim();
    }
    bool status = await Get.find<AuthViewModel>().verifyOTP(otp);
    if (status && mounted) {
      timer.cancel();
      Get.offAndToNamed(AppRoutes.setPasswordScreen);
      return;
    }
    if (mounted) {
      AppSnackBar().showSnackBar(
          title: AppStrings.wrongPinVerificationFieldTitle,
          content: AppStrings.wrongPinVerificationFieldMessage,
          contentType: ContentType.failure,
          color: AppColor.snackBarFailureColor,
          context: context);
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in pinTEControllers) {
      controller.dispose();
    }
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
