import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/screens/dashboard_screen.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/home_screen/model/item_save_model.dart';
import 'package:cbs_erp_project/screens/home_screen/model/unit_reponse.dart';
import 'package:cbs_erp_project/screens/home_screen/provider/home_view_model.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/scanner_page.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemsScreen extends ConsumerStatefulWidget {
  final User user;

  const AddItemsScreen({super.key, required this.user});

  @override
  ConsumerState<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends ConsumerState<AddItemsScreen> {
  CategoryItem? selectItem;
  Unit? selectBaseUnitItems;
  final itemNameController = TextEditingController();
  final itemAliasController = TextEditingController();
  final barcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool barcodeRead = false;
  List<CategoryItem> categoryItem = [];
  List<Unit> unitListItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(getAllCategoryItemsForDropDown.notifier)
          .getCategoryDropDownItems();
      ref.read(getUnitItems.notifier).getUnits();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ApiState>(getAllCategoryItemsForDropDown, (previous, next) {
      if (next.data != null) {
        setState(() {
          categoryItem = next.data.data as List<CategoryItem>;
        });
      } else if (next.errorMessage != null) {
        ErrorHandler.errorHandle(
          next.errorMessage!,
          'Something Wring',
          context,
        );
      }
    });
    ref.listen<ApiState>(getUnitItems, (previous, next) {
      if (next.data != null) {
        setState(() {
          unitListItems = next.data.data as List<Unit>;
        });
      } else if (next.errorMessage != null) {
        ErrorHandler.errorHandle(
          next.errorMessage!,
          'Something Wring',
          context,
        );
      }
    });
    ref.listen(saveItem, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (wasLoading && !next.isLoading) {
        if (next.data != null) {
          final ItemSaveResponse saveModel = next.data as ItemSaveResponse;
          if (saveModel.success == false) {
            ErrorHandler.errorHandle(saveModel.msg ?? '', 'Error', context);
            return;
          } else {
            showDialogForSuccess(next.data);
          }
        }
      } else if (next.errorMessage != null) {
        ErrorHandler.errorHandle(
          next.errorMessage ?? '',
          'Something Wrong',
          context,
        );
      }
    });
    final apiState = ref.watch(saveItem);
    final isLoading = apiState.isLoading;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add items', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          items: categoryItem,
                          labelBuilder: (item) => item.categoryName!,
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
                          items: unitListItems,
                          label: 'Base Unit',
                          hint: 'Select Base Unit',
                          value: selectBaseUnitItems,
                          labelBuilder: (baseUnitItem) =>
                              baseUnitItem.unitName!,
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
                          onTap: () async {
                            final result = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ScannerPage(),
                              ),
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
                            if (formKey.currentState!.validate()) {
                              final bodyParams = {
                                "item_category_id": selectItem?.id,
                                "item_alias": itemAliasController.text.trim(),
                                "item_name": itemNameController.text.trim(),
                                "base_unit_id": selectBaseUnitItems?.id,
                                "barcode": barcodeController.text.trim(),
                                "user_id": widget.user.id,
                              };
                              ref.read(saveItem.notifier).saveItem(bodyParams);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  void showDialogForSuccess(ItemSaveResponse? data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(data?.msg ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (data?.success == true) {
                  itemNameController.clear();
                  itemAliasController.clear();
                  barcodeController.clear();
                  setState(() {
                    selectItem = null;
                    selectBaseUnitItems = null;
                  });
                }
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
