import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:cbs_erp_project/widgets/debug_nointernetdata.dart';
import 'package:cbs_erp_project/widgets/network_aware_wrapper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final urlController = TextEditingController();
  final branchController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NetworkAwareWrapper(
        child: SingleChildScrollView(
          reverse: false,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
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
                ),
                const SizedBox(height: 10),
                CustomTextView.largeTextView(
                  "CBS ERP",
                  AppColors.primaryColors,
                  false,
                ),
                const SizedBox(height: 5),
                CustomTextView.mediumTextView(
                  "Welcome Back",
                  Colors.black54,
                  false,
                ),
                const SizedBox(height: 5),
                CustomTextView.normalTextView(
                  "Sign in to manage your procurement assets",
                  Colors.black54,
                  false,
                ),
                const SizedBox(height: 10),
                Padding(
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
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              label: "URL",
                              hint: "https://cbsdemo.infobraintechs.com",
                              prefixIcon: Icons.link,
                              controller: urlController,
                              validator: (val){
                                if(val == null || val.trim().isEmpty){
                                  return "Please enter your url";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Branch",
                              hint: "Enter branch",
                              prefixIcon: Icons.location_on,
                              controller: branchController,
                              validator: (val){
                                if(val == null || val.trim().isEmpty){
                                  return "Please enter branch";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "User Name",
                              hint: "Enter user name",
                              prefixIcon: Icons.person,
                              controller: userNameController,
                              validator: (val){
                                if(val == null || val.trim().isEmpty){
                                  return "Please enter user name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Password",
                              hint: "Enter password",
                              prefixIcon: Icons.lock,
                              isPassword: true,
                              controller: passwordController,
                              validator: (val){
                                if(val == null || val.trim().isEmpty){
                                  return "Please enter valid password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomButton(txt: 'Login', onPressed: () {
                              if(formKey.currentState!.validate()){
                                print('validate');
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              'Info Technologies Pvt. Ltd.',
              AppColors.colorBlack,
              false,
            ),
          ),
        ),
      ),
    );
  }
}
