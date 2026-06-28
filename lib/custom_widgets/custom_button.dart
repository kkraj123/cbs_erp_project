import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.primaryColors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomTextView.normalTextView(txt, Colors.white, false),
        ),
      ),
    );
  }
}
