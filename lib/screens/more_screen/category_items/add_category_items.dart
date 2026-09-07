import 'package:cbs_erp_project/custom_widgets/custom_button.dart';
import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/custom_widgets/custom_textfield.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategorySaveItemResponse.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategryItems.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/provider/cateogry_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCategoryItems extends ConsumerStatefulWidget {
  final User user;

  const AddCategoryItems({super.key, required this.user});

  @override
  ConsumerState<AddCategoryItems> createState() => _AddCategoryItemsState();
}

class _AddCategoryItemsState extends ConsumerState<AddCategoryItems> {
  CategoryItemsType? selectItem;
  final categoryNameController = TextEditingController();
  final categoryAliasController = TextEditingController();
  final categoryNameLocaleController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLogical = false;
  List<CategoryItemsType> itemsTypeList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(itemsTypeProvider.notifier).getCategoryItemsType();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemsTypeProvider, (previous, next) {
      if (next.data != null) {
        setState(() {
          itemsTypeList = next.data?.data as List<CategoryItemsType>;
        });
      }
      if (next.errorMessage != null) {
        ErrorHandler.errorHandle(
          next.errorMessage ?? '',
          "Somethink Wrong",
          context,
        );
      }
    });
    ref.listen(saveCategoryProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (wasLoading && !next.isLoading) {
        if (next.data != null) {
          final CategorySaveItemResponse saveModel =
              next.data as CategorySaveItemResponse;
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
    final state = ref.watch(saveCategoryProvider);
    final isLoading = state.isLoading;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Category Item', style: TextStyle(color: Colors.white)),
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
                          items: itemsTypeList,
                          labelBuilder: (item) => item.itemTypeName ?? '',
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
                            borderRadius: BorderRadius.circular(10),
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
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isLogical = newValue ?? false;
                                  });
                                },
                              ),
                              CustomTextView.normalTextView(
                                'Is Logical',
                                Colors.black,
                                false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        CustomButton(
                          txt: 'Submit',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final bodyParams = {
                                "item_type_id": selectItem?.id,
                                "category_alias": categoryAliasController.text
                                    .trim(),
                                "category_name": categoryNameController.text
                                    .trim(),
                                "category_name_locale":
                                    categoryNameLocaleController.text.trim(),
                                "description": categoryDescriptionController
                                    .text
                                    .trim(),
                                "is_logical": isLogical,
                                "parent_id": null,
                                "user_id": widget.user.id,
                              };
                              ref
                                  .read(saveCategoryProvider.notifier)
                                  .saveCategoryItem(bodyParams);
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

  void showDialogForSuccess(CategorySaveItemResponse? data) {
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
                if (data?.success == true) {}
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
