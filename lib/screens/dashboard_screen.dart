import 'package:border_bottom_navigation_bar/border_bottom_navigation_bar.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/support/dialog_manager.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/screens/login_screen/model/UserLoginModel.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final AuthModel responseData;
  final String branchCode;
  final String password;
  final String userName;

  const DashboardScreen({
    super.key,
    required this.responseData,
    required this.branchCode,
    required this.password,
    required this.userName,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String loginPin = '';
  String finalDeviceToken = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadLoginPin();
  }

  loadLoginPin() async {
    loginPin = await SharedPreferenceManager.getLoginPin();
    finalDeviceToken =
        await SharedPreferenceManager.getOtpPermanentDeviceToken();
    print('loginPin :$loginPin');
    if (loginPin.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSetPinDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => DialogManager.showExitDialog(context),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: CustomTextView.mediumTextView(
            "Dashboard Screen",
            Colors.black,
            true,
          ),
        ),
        bottomNavigationBar: BorderBottomNavigationBar(
          height: 85,
          currentIndex: _currentIndex,
          borderRadiusValue: 20,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppColors.primaryColors,
          selectedBackgroundColor: AppColors.backgroundColor,

          selectedLabelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          unselectedBackgroundColor: Colors.transparent,
          unselectedIconColor: Colors.white,
          selectedIconColor: Colors.black,
          selectedIconSize: 25,
          unselectedIconSize: 25,
          customBottomNavItems: [
            BorderBottomNavigationItems(
              icon: Icons.dashboard,
              label: 'Home',
            ),
            BorderBottomNavigationItems(
              icon: Icons.send_to_mobile_rounded,
              label: 'Send',
            ),
            BorderBottomNavigationItems(
              icon: Icons.file_copy,
              label: 'Report',
            ),
            BorderBottomNavigationItems(icon: Icons.more_horiz, label: 'More'),
          ],
        ),
      ),
    );
  }

  void _showSetPinDialog() {
    final TextEditingController pinController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Set Login PIN',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please set a PIN for quick login.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "",
                hint: 'Login Pin',
                controller: pinController,
                isPassword: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Login Pin";
                  }
                  if (value.length < 4) {
                    return "PIN must be 4 digits";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
            child: const Text('Cancel'),
          ),
          InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                SharedPreferenceManager.setLoginPin(
                  pinController.text.toString().trim(),
                );
                SharedPreferenceManager.setUserLoginDetails(
                  UserLoginPinModel(
                    branchCode: widget.branchCode,
                    userName: widget.userName,
                    password: widget.password,
                    deviceToken: finalDeviceToken,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColors,
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: TextScaler.linear(1.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
