import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/home_screen/add_items_screen.dart';
import 'package:cbs_erp_project/screens/home_screen/model/recent_items_model.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/items/all_items_screen.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AuthModel authModel;

  const HomeScreen({super.key, required this.authModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<RecentItemsModel> recentItemList = [
    RecentItemsModel(
      id: 1,
      icon: Icons.shopify_outlined,
      itemName: 'Wireless Mouse',
      txnId: 'TXN_9900',
      price: '700',
      status: 'Pending',
    ),
    RecentItemsModel(
      id: 2,
      icon: Icons.shopify_outlined,
      itemName: 'Wireless Mouse',
      txnId: 'TXN_9900',
      price: '700',
      status: 'Pending',
    ),
    RecentItemsModel(
      id: 3,
      icon: Icons.shopify_outlined,
      itemName: 'Wireless Mouse',
      txnId: 'TXN_9900',
      price: '700',
      status: 'Pending',
    ),
    RecentItemsModel(
      id: 4,
      icon: Icons.shopify_outlined,
      itemName: 'Wireless Mouse',
      txnId: 'TXN_9900',
      price: '700',
      status: 'Pending',
    ),
    RecentItemsModel(
      id: 5,
      icon: Icons.shopify_outlined,
      itemName: 'Wireless Mouse',
      txnId: 'TXN_9900',
      price: '700',
      status: 'Pending',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagerWrapper(
      user: widget.authModel.user,
      child: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView.mediumTextView("Overview", Colors.black87, false),
              CustomTextView.normalTextView(
                "Your trading activity is looking strong today.",
                AppColors.colorBlack,
                false,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.2, color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryColors.withAlpha(
                                      100,
                                    ),
                                  ),
                                  child: Icon(Icons.trending_up),
                                ),
                                CustomTextView.mediumTextView(
                                  "50%",
                                  AppColors.primaryColors,
                                  false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.normalTextView(
                              "Total Sales",
                              Colors.black,
                              false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.mediumTextView(
                              "NRS. 24,000",
                              AppColors.primaryColors,
                              false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.2, color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryColors.withAlpha(
                                      100,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.shopping_cart_checkout_outlined,
                                  ),
                                ),
                                CustomTextView.mediumTextView(
                                  "12%",
                                  AppColors.primaryColors,
                                  false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.normalTextView(
                              "Total Purchase",
                              Colors.black,
                              false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.mediumTextView(
                              "NRS. 54,000",
                              AppColors.primaryColors,
                              false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Quick Actions',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textScaler: TextScaler.linear(1.2),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddItemsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColors,
                        ),
                        child: Center(
                          child: CustomTextView.mediumTextWithNormalView(
                            'Add Items',
                            Colors.white,
                            false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllItemsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.2,
                            color: AppColors.primaryColors,
                          ),
                        ),
                        child: Center(
                          child: CustomTextView.mediumTextWithNormalView(
                            'Items',
                            AppColors.primaryColors,
                            false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    textScaler: TextScaler.linear(1.2),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primaryColors,
                      fontWeight: FontWeight.normal,
                    ),
                    textScaler: TextScaler.linear(1.2),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recentItemList.length,
                  itemBuilder: (context, index) {
                    final items = recentItemList[index];
                    return RecentViewItems(items);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget RecentViewItems(RecentItemsModel items) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 70,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
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
                        color: AppColors.primaryColors.withAlpha(40),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(items.icon, color: AppColors.primaryColors),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextView.mediumTextWithNormalView(
                          items.itemName,
                          Colors.black,
                          false,
                        ),
                        CustomTextView.normalTextView(
                          items.txnId,
                          Colors.grey,
                          false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    CustomTextView.normalTextView(
                      "NPR. ${items.price}",
                      Colors.green,
                      false,
                    ),
                    CustomTextView.normalTextView(
                      items.status,
                      Colors.orange,
                      false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
