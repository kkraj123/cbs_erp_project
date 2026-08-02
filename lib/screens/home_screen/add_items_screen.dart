import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add items', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: Center(child: Text('Add Items')),
    );
  }
}
