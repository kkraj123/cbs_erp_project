import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddCategoryItems extends StatefulWidget {
  const AddCategoryItems({super.key});

  @override
  State<AddCategoryItems> createState() => _AddCategoryItemsState();
}

class _AddCategoryItemsState extends State<AddCategoryItems> {
  List<ItemModel> itemList = [
    ItemModel(productName: 'saving item', productId: '1'),
    ItemModel(productName: 'saving1 item', productId: '2'),
    ItemModel(productName: 'saving2 item', productId: '3'),
  ];

  ItemModel? selectItem;
  final categoryNameController = TextEditingController();
  final categoryAliasController = TextEditingController();
  final categoryNameLocaleController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLogical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Category Item', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomDropdownV2(
                      items: itemList,
                      labelBuilder: (item) => item.productName,
                      hint: "Select Item",
                      label: 'Items Type',
                      value: selectItem,
                      onChanged: (val) => setState(() => selectItem = val),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Category Name',
                      hint: 'Enter Category Name',
                      controller: categoryNameController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter category name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Category Name Locale',
                      hint: 'Enter Category Name Locale',
                      controller: categoryNameLocaleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter category name locale";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Category Alias',
                      hint: 'Enter Category Alias',
                      controller: categoryAliasController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter category alias";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Description',
                      hint: 'Enter Category description',
                      controller: categoryDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter category description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColors.withAlpha(90),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isLogical,
                            activeColor: AppColors.primaryColors,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: const BorderSide(color: Colors.black, width: 2),
                            onChanged: (bool? newValue) {
                              setState(() {
                                isLogical = newValue ?? false;
                              });
                            },
                          ),
                          CustomTextView.normalTextView('Is Logical', Colors.black, false)
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    CustomButton(
                      txt: 'Submit',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemModel {
  String productName;
  String productId;

  ItemModel({required this.productName, required this.productId});
}
