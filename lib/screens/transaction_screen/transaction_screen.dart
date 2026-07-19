import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final AuthModel authModel;
  const TransactionScreen({super.key, required this.authModel});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return PagerWrapper(
      user: widget.authModel.user,
      child: Center(child: Text('Transaction')),
    );
  }
}
