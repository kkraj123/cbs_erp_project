import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
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
      appBar: AppBar(title: Text('Add items'),),
      body: Center(child: Text('Add Items'),),
    );
  }
}
