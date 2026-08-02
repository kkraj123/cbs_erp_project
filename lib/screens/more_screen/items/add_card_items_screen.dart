import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/main.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddCardItemsScreen extends StatefulWidget {
  const AddCardItemsScreen({super.key});

  @override
  State<AddCardItemsScreen> createState() => _AddCardItemsScreenState();
}

class _AddCardItemsScreenState extends State<AddCardItemsScreen> {
  List<AddCardModel> addCartItems = [
    AddCardModel(3, '', 'Dell Laptop', 'Dell Item description', "35,000"),
    AddCardModel(3, '', 'Dell Laptop', 'Dell Item description', "35,000"),
    AddCardModel(3, '', 'Dell Laptop', 'Dell Item description', "35,000"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: addCartItems.length,
          itemBuilder: (context, index) {
            final item = addCartItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColors.withAlpha(40),
                  border: Border.all(width: 1, color: AppColors.primaryColors),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.primaryColors,
                                  ),
                                ),
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 60,
                                  color: AppColors.primaryColors,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextView.mediumTextWithNormalView(
                                    item.itemName,
                                    Colors.black,
                                    false,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomTextView.normalTextView(
                                    item.itemDescription,
                                    Colors.black38,
                                    false,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomTextView.normalTextView(
                                    "NPR. ${item.price}",
                                    Colors.black38,
                                    false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextView.normalTextView("Total Item", Colors.black, false),
                          CustomTextView.mediumTextWithNormalView("${item.totalItem}", Colors.black, false),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddCardModel {
  int totalItem;
  String img;
  String itemName;
  String itemDescription;
  String price;

  AddCardModel(
    this.totalItem,
    this.img,
    this.itemName,
    this.itemDescription,
    this.price,
  );
}
