import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  final AuthModel authModel;
  const ReportScreen({super.key, required this.authModel});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return PagerWrapper(
      user: widget.authModel.user,
      child: Center(child: Text('Report')),
    );
  }
}
