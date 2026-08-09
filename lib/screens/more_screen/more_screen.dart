import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/home_screen/model/recent_items_model.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/add_category_items.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/category_item_screen.dart';
import 'package:cbs_erp_project/screens/more_screen/items/all_items_screen.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/unit_measure_screen.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  final AuthModel authModel;

  const MoreScreen({super.key, required this.authModel});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final List<RecentItemsModel> settingListItems = [
    RecentItemsModel(
      id: 1,
      icon: Icons.food_bank_rounded,
      itemName: 'Account Types',
      txnId: '',
      price: '',
      status: '',
    ),
    RecentItemsModel(
      id: 2,
      icon: Icons.wallet,
      itemName: 'Customer Setup',
      txnId: '',
      price: '',
      status: '',
    ),
    RecentItemsModel(
      id: 3,
      icon: Icons.wallet_giftcard,
      itemName: 'Account Setup',
      txnId: '',
      price: '',
      status: '',
    ),
    RecentItemsModel(
      id: 4,
      icon: Icons.wallet_giftcard,
      itemName: 'Item Category',
      txnId: '',
      price: '',
      status: '',
    ),
    RecentItemsModel(
      id: 5,
      icon: Icons.wallet_giftcard,
      itemName: 'Units Of Measure',
      txnId: '',
      price: '',
      status: '',
    ),
    RecentItemsModel(
      id: 6,
      icon: Icons.wallet_giftcard,
      itemName: 'Items',
      txnId: '',
      price: '',
      status: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PagerWrapper(
      user: widget.authModel.user,
      child: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView.mediumTextView("Settings", Colors.black87, false),
              CustomTextView.normalTextView(
                "Configure your operational parameters and organizational structure.",
                AppColors.colorBlack,
                false,
              ),
              const SizedBox(height: 25),
              Text(
                'Financial Hierarchy',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textScaler: TextScaler.linear(1.2),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: settingListItems.length,
                itemBuilder: (context, index) {
                  final item = settingListItems[index];
                  BorderRadius borderRadius;

                  if (index == 0) {
                    borderRadius = const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    );
                  } else if (index == settingListItems.length - 1) {
                    borderRadius = const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    );
                  } else {
                    borderRadius = BorderRadius.zero;
                  }
                  return InkWell(
                    onTap: () {
                      switch (item.id) {
                        case 4: {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoryItemScreen(),
                            ),
                          );
                          break;
                        }
                        case 5: {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UnitMeasureScreen(),
                            ),
                          );
                          break;
                        }
                        case 6:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AllItemsScreen(),
                              ),
                            );
                            break;
                          }
                        default :
                          print("Empty items");
                      }
                    },
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border: Border(
                          left: BorderSide(color: Colors.grey.shade300),
                          right: BorderSide(color: Colors.grey.shade300),
                          bottom: BorderSide(color: Colors.grey.shade300),
                          top: index == 0
                              ? BorderSide(color: Colors.grey.shade300)
                              : BorderSide.none,
                        ),
                        color: Colors.grey.shade50,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColors.withAlpha(
                                        40,
                                      ),
                                    ),
                                    child: Icon(
                                      item.icon,
                                      size: 20,
                                      color: AppColors.primaryColors,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CustomTextView.normalTextView(
                                    item.itemName,
                                    Colors.black87,
                                    false,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
