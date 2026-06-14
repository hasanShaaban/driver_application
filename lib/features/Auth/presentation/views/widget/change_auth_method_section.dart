import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ChangeAuthMethodSection extends StatelessWidget {
  const ChangeAuthMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ليس لديك حساب؟ ',
                  style: AppTextStyle.regular15.copyWith(
                    color: const Color(0xFF807F7F),
                  ),
                ),
                TextSpan(
                  text: 'سجل هنا',
                  style: AppTextStyle.regular15.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
