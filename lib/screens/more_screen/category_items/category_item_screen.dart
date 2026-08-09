import 'package:cbs_erp_project/screens/more_screen/category_items/add_category_items.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItemScreen extends StatefulWidget {
  const CategoryItemScreen({super.key});

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Category Item', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColors,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategoryItems()),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white,),
        label: const Text('Add Category', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
