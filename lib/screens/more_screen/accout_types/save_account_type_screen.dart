import 'package:cbs_erp_project/custom_widgets/custom_dropdown_view.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/FinTypeListItems.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/provider/account_type_view_holder.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveAccountTypeScreen extends ConsumerStatefulWidget {
  final User user;

  const SaveAccountTypeScreen({super.key, required this.user});

  @override
  ConsumerState<SaveAccountTypeScreen> createState() => _SaveAccountTypeScreenState();
}

class _SaveAccountTypeScreenState extends ConsumerState<SaveAccountTypeScreen> {

  List<FinTypeListItems> finTypeList = [];
  FinTypeListItems? selectFinType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(finTypeListProvider.notifier).getFinTypeList();
    });
  }
  @override
  Widget build(BuildContext context) {
    ref.listen(finTypeListProvider, (previous, next) {
      if (next.data != null) {
        setState(() {
          finTypeList = next.data?.data as List<FinTypeListItems>;
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Save Account Types',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColors,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          reverse: false,
          child: Column(children: [
            CustomDropdownV2(
              items: finTypeList,
              labelBuilder: (item) => item.finCategoryName ?? '',
              hint: "Select Fin Type",
              label: 'Fin Type',
              value: selectFinType,
              onChanged: (val) => setState(() => selectFinType = val),
            ),
          ]),
        ),
      ),
    );
  }
}
