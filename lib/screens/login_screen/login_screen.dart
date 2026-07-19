import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/screens/dashboard_screen.dart';
import 'package:cbs_erp_project/screens/login_screen/model/UserLoginModel.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/login_screen/otp_screen.dart';
import 'package:cbs_erp_project/screens/login_screen/provider/login_provider.dart';
import 'package:cbs_erp_project/screens/login_screen/provider/login_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:cbs_erp_project/widgets/network_aware_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String loginPin;

  const LoginScreen({super.key, required this.loginPin});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final urlController = TextEditingController();
  final branchController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginPinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserLoginPinModel? userLoginPinModel;

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    final url = urlController.text.trim();
    if (!url.startsWith("https://")) {
      ErrorHandler.errorHandle(
        "URL must start with https://",
        "Invalid URL",
        context,
      );
      return;
    }

    await SharedPreferenceManager.setBaseUrl(url);
    ref.read(baseUrlProvider.notifier).state = url;

    final deviceToken =
        await SharedPreferenceManager.getOtpPermanentDeviceToken();

    await ref
        .read(loginViewModelProvider.notifier)
        .loginApi(
          branchCode: branchController.text.trim(),
          userName: userNameController.text.trim(),
          password: passwordController.text,
          deviceToken: deviceToken ?? '',
        );
  }

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    print('loginPinPrint ${widget.loginPin}');
  }

  loadUserDetails() async {
    final savedUrl = await SharedPreferenceManager.getBaseUrl();
    if (savedUrl != null && savedUrl.isNotEmpty) {
      ref.read(baseUrlProvider.notifier).state = savedUrl;
    }
    userLoginPinModel = await SharedPreferenceManager.getUserLoginDetails();
    if (userLoginPinModel != null) {
      print('userDetails :${userLoginPinModel!.toJson()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ApiState>(loginViewModelProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (wasLoading && !next.isLoading) {
        if (next.data != null) {
          final AuthModel authModel = next.data as AuthModel;
          if (authModel.success == false) {
            ErrorHandler.errorHandle(
              (authModel.msg ?? '').replaceAll('\n', ' '),
              'Login Failed',
              context,
            );
            return;
          }
          SharedPreferenceManager.setLoginDeviceToken(
            authModel.deviceToken ?? '',
          );
          SharedPreferenceManager.setUser(authModel.user!);
          SharedPreferenceManager.setFirstCallOnboarding(true);

          if (authModel.requireOtpVerification == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  userName: userNameController.text.trim(),
                  password: passwordController.text.trim(),
                  branchCode: branchController.text.trim(),
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(
                  responseData: authModel,
                  userName: userNameController.text.trim(),
                  password: passwordController.text.trim(),
                  branchCode: branchController.text.trim(),
                ),
              ),
            );
          }
        } else if (next.errorMessage != null) {
          ErrorHandler.errorHandle(next.errorMessage!, "Login Failed", context);
        }
      }
    });

    final apiState = ref.watch(loginViewModelProvider);
    final isLoading = apiState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        reverse: false,
        child: NetworkAwareWrapper(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.boxColors.withAlpha(50),
                              border: Border.all(
                                width: 1,
                                color: AppColors.primaryColors,
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
                    ),
                    const SizedBox(height: 10),
                    CustomTextView.largeTextView(
                      "Balance ERP",
                      AppColors.colorWhite,
                      false,
                    ),
                    const SizedBox(height: 5),
                    CustomTextView.mediumTextView(
                      "Welcome Back",
                      Colors.white,
                      false,
                    ),
                    const SizedBox(height: 5),
                    CustomTextView.normalTextView(
                      "Sign in to manage your procurement assets",
                      AppColors.boxColors,
                      false,
                    ),
                    const SizedBox(height: 10),
                    widget.loginPin.isEmpty
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                                color: AppColors.primaryColors.withAlpha(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        label: "URL",
                                        hint:
                                            "https://cbsdemo.infobraintechs.com",
                                        prefixIcon: Icons.link,
                                        controller: urlController,
                                        validator: (val) {
                                          if (val == null || val.trim().isEmpty) {
                                            return "Please enter your url";
                                          }
                                          return null;
                                        },
                                        borderColor: AppColors.primaryColors,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        borderColor: AppColors.primaryColors,
                                        label: "Branch",
                                        hint: "Enter branch",
                                        prefixIcon: Icons.location_on,
                                        controller: branchController,
                                        validator: (val) {
                                          if (val == null || val.trim().isEmpty) {
                                            return "Please enter branch";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        borderColor: AppColors.primaryColors,
                                        label: "User Name",
                                        hint: "Enter user name",
                                        prefixIcon: Icons.person,
                                        controller: userNameController,
                                        validator: (val) {
                                          if (val == null || val.trim().isEmpty) {
                                            return "Please enter user name";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        borderColor: AppColors.primaryColors,
                                        label: "Password",
                                        hint: "Enter password",
                                        prefixIcon: Icons.lock,
                                        isPassword: true,
                                        controller: passwordController,
                                        validator: (val) {
                                          if (val == null || val.trim().isEmpty) {
                                            return "Please enter valid password";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomButton(
                                        txt: 'Login',
                                        onPressed: () {
                                          if (!isLoading) {
                                            _handleLogin();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : loginPinView(context),
                  ],
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
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: CustomTextView.normalTextView(
              'Infobrain Technologies Pvt. Ltd.',
              AppColors.colorWhite,
              false,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginPinView(BuildContext context) {
    final pinFormKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12),
          color: AppColors.colorWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: pinFormKey,
            child: Column(
              children: [
                CustomTextField(
                  label: "Login Pin",
                  hint: "Enter login pin",
                  keyboardType: TextInputType.number,
                  controller: loginPinController,
                  isPassword: true,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter login pin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: CustomButton(
                    txt: 'Login',
                    onPressed: () async {
                      if (pinFormKey.currentState!.validate()) {
                        if (loginPinController.text.trim() == widget.loginPin) {
                          if (userLoginPinModel != null) {
                            ref.read(loginViewModelProvider.notifier).loginApi(
                                  branchCode: userLoginPinModel!.branchCode,
                                  userName: userLoginPinModel!.userName,
                                  password: userLoginPinModel!.password,
                                  deviceToken: userLoginPinModel!.deviceToken,
                                );
                          }
                        } else {
                          ErrorHandler.errorHandle(
                            "Login PIN does not match.",
                            "Login Pin",
                            context,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
