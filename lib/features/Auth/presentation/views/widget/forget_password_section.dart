import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ForgetPasswordSection extends StatelessWidget {
  const ForgetPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Text(
          'نسيت كلمة المرور؟',
          style: AppTextStyle.regular15.copyWith(
            color: AppColors.primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
