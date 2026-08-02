import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/screens/more_screen/items/add_card_items_screen.dart';
import 'package:cbs_erp_project/screens/more_screen/items/model/item_response.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item itemDetails;

  const ItemDetailsScreen({super.key, required this.itemDetails});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int addItems = 0;

  @override
  Widget build(BuildContext context) {
    final min = widget.itemDetails.minStockLevel ?? 0;
    final max = widget.itemDetails.maxStockLevel ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            backgroundColor: AppColors.primaryColors,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 16,
                bottom: 20,
                right: 16,
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.itemDetails.itemName ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textScaler: TextScaler.linear(0.7),
                  ),
                  Text(
                    widget.itemDetails.itemNameLocale ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    textScaler: TextScaler.linear(0.6),
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondaryColor,
                      AppColors.primaryColors.withOpacity(0.75),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.inventory_2_rounded,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: Center(child: Text("Min Stock - $min")),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: Center(child: Text("Max Stock - $max")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextView.mediumTextWithNormalView(
                    'Description',
                    Colors.grey,
                    false,
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomTextView.normalTextView(
                      "${widget.itemDetails.description}",
                      Colors.grey,
                      false,
                    ),
                  ),
                  const SizedBox(height: 15),
                  widget.itemDetails.categoryName != null
                      ? CustomTextView.mediumTextWithNormalView(
                          'Category',
                          Colors.grey,
                          false,
                        )
                      : SizedBox.shrink(),
                  widget.itemDetails.categoryName != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomTextView.normalTextView(
                            '${widget.itemDetails.categoryName}',
                            Colors.grey,
                            false,
                          ),
                        )
                      : SizedBox.shrink(),

                  const SizedBox(height: 15),
                  CustomTextView.mediumTextWithNormalView(
                    'Item Alias',
                    Colors.grey,
                    false,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: CustomTextView.normalTextView(
                      "${widget.itemDetails.itemAlias} (${widget.itemDetails.itemNameLocale})",
                      Colors.grey,
                      false,
                    ),
                  ),
                  const SizedBox(height: 15),
                  widget.itemDetails.barcode!.isNotEmpty
                      ? CustomTextView.mediumTextWithNormalView(
                          'Barcode',
                          Colors.grey,
                          false,
                        )
                      : SizedBox.shrink(),
                  widget.itemDetails.barcode!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: CustomTextView.normalTextView(
                            "${widget.itemDetails.barcode}",
                            Colors.grey,
                            false,
                          ),
                        )
                      : SizedBox.shrink(),

                  const SizedBox(height: 15),
                  CustomTextView.mediumTextWithNormalView(
                    'insert Date',
                    Colors.grey,
                    false,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: CustomTextView.normalTextView(
                      _formatDate(widget.itemDetails.insertDate),
                      Colors.grey,
                      false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: AppColors.primaryColors,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (addItems > 0) {
                              addItems--;
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: Center(
                            child: Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      CustomTextView.mediumTextView(
                        "$addItems",
                        Colors.white,
                        true,
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            addItems++;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: Center(
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardItemsScreen()));
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Add Card',
                      style: TextStyle(color: AppColors.primaryColors),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final local = date.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year.toString();
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$d/$m/$y  $h:$min';
  }
}
