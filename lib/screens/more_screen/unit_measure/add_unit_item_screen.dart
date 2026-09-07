import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/uni_save_response.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/providers/unit_measure_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUnitItemScreen extends ConsumerStatefulWidget {
  final User user;

  const AddUnitItemScreen({super.key, required this.user});

  @override
  ConsumerState<AddUnitItemScreen> createState() => _AddUnitItemState();
}

class _AddUnitItemState extends ConsumerState<AddUnitItemScreen> {
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
    ref.listen(saveUnitMeasureProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (wasLoading && !next.isLoading) {
        if (next.data != null) {
          final UniSaveResponse saveModel = next.data as UniSaveResponse;
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
    final apiState = ref.watch(saveUnitMeasureProvider);
    final isLoading = apiState.isLoading;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Unit Item', style: TextStyle(color: Colors.white)),
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
                          keyboardType: TextInputType.number,
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
                            if (formKey.currentState!.validate()) {
                              final bodyParams = {
                                "unit_alias": uniAliasController.text.trim(),
                                "unit_name": unitNameController.text.trim(),
                                "base_unit_id": 5,
                                "conversion_factor": conversionFactorController
                                    .text
                                    .trim(),
                                "description": unitDescriptionController.text
                                    .trim(),
                                "user_id": widget.user.id,
                              };
                              ref
                                  .read(saveUnitMeasureProvider.notifier)
                                  .saveUnitMeasureItem(bodyParams);
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

  void showDialogForSuccess(UniSaveResponse? data) {
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
                  unitDescriptionController.clear();
                  unitNameController.clear();
                  uniAliasController.clear();
                  conversionFactorController.clear();
                  // setState(() {
                  //   selectItem = null;
                  //   selectBaseUnitItems = null;
                  // });
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

class ItemModel {
  String productName;
  String productId;

  ItemModel({required this.productName, required this.productId});
}
