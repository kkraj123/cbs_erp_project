import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/screens/common_widget/pager_wrapper.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AuthModel authModel;

  const HomeScreen({super.key, required this.authModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.normalTextView("Total Sales", Colors.black, false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.mediumTextView("NRS. 24,000", AppColors.primaryColors, false),
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
                                  child: Icon(Icons.shopping_cart_checkout_outlined),
                                ),
                                CustomTextView.mediumTextView(
                                  "12%",
                                  AppColors.primaryColors,
                                  false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.normalTextView("Total Purchase", Colors.black, false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CustomTextView.mediumTextView("NRS. 54,000", AppColors.primaryColors, false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
