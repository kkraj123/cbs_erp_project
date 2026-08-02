import 'package:cbs_erp_project/custom_widgets/custom_appbar.dart';
import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/network/support/error_handler.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/unit_measure_response_model.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/providers/unit_measure_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitMeasureScreen extends ConsumerStatefulWidget {
  const UnitMeasureScreen({super.key});

  @override
  ConsumerState<UnitMeasureScreen> createState() => _UnitMeasureScreenState();
}

class _UnitMeasureScreenState extends ConsumerState<UnitMeasureScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getUnitMeasureProvider.notifier).getAllUnitMeasureItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getUnitMeasureProvider);
    return Scaffold(
      appBar: CustomAppbar(title: 'Units Of Measure'),
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () => ref
              .read(getUnitMeasureProvider.notifier)
              .getAllUnitMeasureItems(),
          child: _buildUnitListItems(state, context),
        ),
      ),
    );
  }

  Widget _buildUnitListItems(
    ApiState<UnitMeasureResponseModel> state,
    BuildContext context,
  ) {
    if (state.isLoading)
      return Center(child: const CircularProgressIndicator());

    if (state.errorMessage != null) {
      return Center(child: Text(state.errorMessage ?? 'Something error'));
    }
    if (state.data?.data == null)
      return const Center(child: Text('Data not found'));

    final unitListItems = state.data?.data ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: unitListItems.length,
      itemBuilder: (context, index) {
        final units = unitListItems[index];
        return Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColors.withAlpha(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextView.normalTextView(
                        "${units.unitName} (${units.unitNameLocale})",
                        Colors.grey,
                        false,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: units.status == true
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8,
                            bottom: 4,
                          ),
                          child: CustomTextView.normalTextView(
                            units.status == true ? 'Active' : "Inactive",
                            Colors.white,
                            false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomTextView.normalTextView(
                              "Unit : ${units.unitAlias}",
                              Colors.black,
                              false,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          CustomTextView.normalTextView("${units.unitName} Factor : ${units.conversionFactor}", Colors.black, false)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
