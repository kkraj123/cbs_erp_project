import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomToolbar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const CustomToolbar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: preferredSize.height,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          child: Icon(Icons.person, size: 25),
                          backgroundColor: AppColors.primaryColors.withAlpha(
                            50,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextView.normalTextView(
                              'Hello, ${user.userName}',
                              Colors.black,
                              false,
                            ),
                            Expanded(
                              child: Text(
                                "ERP",
                                style: TextStyle(
                                  color: AppColors.primaryColors,
                                  fontFamily: 'Barlow',
                                  fontWeight: FontWeight.w600,
                                ),
                                textScaler: TextScaler.linear(1.2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.colorBlack,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            color: Colors.grey,
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
