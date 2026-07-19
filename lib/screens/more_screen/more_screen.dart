import 'package:cbs_erp_project/custom_widgets/custom_toolbar.dart';
import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  final AuthModel authModel;

  const MoreScreen({super.key, required this.authModel});

  @override
  Widget build(BuildContext context) {
    return PagerWrapper(
      user: authModel.user,
      child: Center(child: Text('Setting')),
    );
  }
}
