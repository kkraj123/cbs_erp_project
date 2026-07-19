import 'package:cbs_erp_project/custom_widgets/custom_toolbar.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class PagerWrapper extends StatelessWidget {
  final User? user;
  final Widget child;
  const PagerWrapper({super.key, required this.child, this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: CustomToolbar(user: user!),
        body: child,
      ),
    );
  }
}
