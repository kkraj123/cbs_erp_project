import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddUnitItemScreen extends StatefulWidget {
  const AddUnitItemScreen({super.key});

  @override
  State<AddUnitItemScreen> createState() => _AddUnitItemState();
}

class _AddUnitItemState extends State<AddUnitItemScreen> {
  List<ItemModel> unitItem = [
    ItemModel(productName: 'KG', productId: '1'),
    ItemModel(productName: 'Litter', productId: '2'),
    ItemModel(productName: 'Pieces', productId: '3'),
  ];

  ItemModel? selectItem;
  final uniAliasController = TextEditingController();
  final unitNameController = TextEditingController();
  final unitDescriptionController = TextEditingController();
  final conversionFactorController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLogical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Unit Item', style: TextStyle(color: Colors.white)),
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
                      items: unitItem,
                      labelBuilder: (item) => item.productName,
                      hint: "Select Item",
                      label: 'Base Unit',
                      value: selectItem,
                      onChanged: (val) => setState(() => selectItem = val),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Unit Alias',
                      hint: 'Enter Unit Alias',
                      controller: uniAliasController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter unit alias";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Unit Name',
                      hint: 'Enter Unit Name',
                      controller: unitNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter unit name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Conversion Factor',
                      hint: 'Enter Conversion Factor',
                      controller: conversionFactorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter conversion factor";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Description',
                      hint: 'Enter Unit description',
                      controller: unitDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter unit description";
                        }
                        return null;
                      },
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
