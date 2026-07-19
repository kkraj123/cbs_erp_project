import 'dart:math';

import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/screens/dashboard_screen.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/login_screen/provider/login_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:cbs_erp_project/widgets/network_aware_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String branchCode;
  final String password;
  final String userName;

  const OtpScreen({
    super.key,
    required this.branchCode,
    required this.password,
    required this.userName,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<ApiState>(loginViewModelProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (wasLoading && !next.isLoading) {
        if (next.data != null) {
          SharedPreferenceManager.setFirstCallOnboarding(true);
          SharedPreferenceManager.setUser(next.data.user);
          AuthModel authModel = next.data as AuthModel;

          SharedPreferenceManager.setOtpPermanentDeviceToken(
            authModel.deviceToken!,
          );
          if (authModel.success == false) {
            ErrorHandler.errorHandle(next.errorMessage!, 'OTP Wrong', context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(
                  responseData: authModel,
                  userName: widget.userName,
                  password: widget.password,
                  branchCode: widget.branchCode,
                ),
              ),
            );
          }

        } else if (next.errorMessage != null) {
          ErrorHandler.errorHandle(next.errorMessage!, "OTP Failed", context);
        }
      }
    });
    final apiState = ref.watch(loginViewModelProvider);
    final isLoading = apiState.isLoading;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: NetworkAwareWrapper(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 25, left: 25),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColors,
                              border: Border.all(
                                width: 1,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.business_center,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextView.largeTextView(
                        "Balance ERP",
                        AppColors.primaryColors,
                        false,
                      ),
                      const SizedBox(height: 5),
                      CustomTextView.normalTextView(
                        "Enter the otp verification code sent to your registered email address.",
                        Colors.white,
                        true,
                      ),
                      CustomTextField(
                        label: "",
                        hint: "Enter OTP",
                        controller: otpController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter valid otp";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                          txt: "Verify",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final deviceToken =
                                  await SharedPreferenceManager.getLoginDeviceToken();
                              await ref
                                  .read(loginViewModelProvider.notifier)
                                  .otpVerification(
                                    branchCode: widget.branchCode.trim(),
                                    userName: widget.userName.trim(),
                                    password: widget.password.trim(),
                                    deviceToken: deviceToken,
                                    otp: otpController.text.trim(),
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CustomTextView.normalTextView(
                          "Cancel",
                          Colors.white,
                          false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
