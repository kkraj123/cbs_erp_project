import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/screens/scanner_page.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  List<ItemModel> itemList = [
    ItemModel(productName: 'saving item', productId: '1'),
    ItemModel(productName: 'saving1 item', productId: '2'),
    ItemModel(productName: 'saving2 item', productId: '3'),
  ];

  List<ItemModel> baseUnit = [
    ItemModel(productName: 'Gram', productId: '1'),
    ItemModel(productName: 'Litter', productId: '2'),
    ItemModel(productName: 'pieces', productId: '3'),
  ];
  ItemModel? selectItem;
  ItemModel? selectBaseUnitItems;
  final itemNameController = TextEditingController();
  final itemAliasController = TextEditingController();
  final barcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool barcodeRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add items', style: TextStyle(color: Colors.white)),
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
                      label: 'Item Name',
                      hint: 'Enter item name',
                      controller: itemNameController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter item name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Item Alias',
                      hint: 'Enter item Alias',
                      controller: itemAliasController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter item Alias";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomDropdownV2(
                      items: baseUnit,
                      label: 'Base Unit',
                      hint: 'Select Base Unit',
                      value: selectBaseUnitItems,
                      labelBuilder: (baseUnitItem) => baseUnitItem.productName,
                      onChanged: (val) =>
                          setState(() => selectBaseUnitItems = val),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Barcode',
                      hint: 'Enter Barcode',
                      controller: barcodeController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter barcode";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () async{
                        final result = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(builder: (context) => const ScannerPage()),
                        );

                        if (result != null) {
                          print('Scanned $result');
                          barcodeController.text = result;
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColors.withAlpha(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/scanner.png',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

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
