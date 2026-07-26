import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final AuthModel authModel;

  const TransactionScreen({super.key, required this.authModel});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<PurchaseModel> purchaseItemList = [
    PurchaseModel(itemName: "Purchase"),
    PurchaseModel(itemName: "Sales"),
    PurchaseModel(itemName: "Transfer"),
    PurchaseModel(itemName: "Sales Return"),
    PurchaseModel(itemName: "Purchase Return"),
  ];

  final List<PurchaseModel> singleTransactionList = [
    PurchaseModel(itemName: "Receipt"),
    PurchaseModel(itemName: "Payment"),
    PurchaseModel(itemName: "Journal Entry"),
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
              CustomTextView.mediumTextView(
                "New Transaction",
                Colors.black87,
                false,
              ),
              CustomTextView.normalTextView(
                "Select an action to record a new entry in your ledger.",
                AppColors.colorBlack,
                false,
              ),
              const SizedBox(height: 25),
              Text(
                'Purchase & Sales Transaction',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textScaler: TextScaler.linear(1.2),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                child: GridView.builder(
                  itemCount: purchaseItemList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 40,
                  ),
                  itemBuilder: (context, index) {
                    final purchaseItem = purchaseItemList[index];
                    return Container(
                      height: 20,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColors.withAlpha(50),
                      ),
                      child: Center(
                        child: CustomTextView.normalTextView(
                          purchaseItem.itemName,
                          Colors.black,
                          false,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Single Entry Transaction',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textScaler: TextScaler.linear(1.2),
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: singleTransactionList.length,
                  itemBuilder: (context, index) {
                    final item = singleTransactionList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 70,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.2,
                            color: AppColors.primaryColors.withAlpha(80),
                          ),
                          color: Colors.grey.shade50,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColors
                                            .withAlpha(50),
                                      ),
                                      child: Icon(
                                        Icons.receipt_long,
                                        color: AppColors.primaryColors,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextView.mediumTextWithNormalView(
                                          item.itemName,
                                          Colors.black,
                                          false,
                                        ),
                                        CustomTextView.normalTextView(
                                          'Record incoming payment',
                                          Colors.grey,
                                          false,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseModel {
  final String itemName;

  PurchaseModel({required this.itemName});
}
