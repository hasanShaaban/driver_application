import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';

class OrderNumberContainer extends StatelessWidget {
  const OrderNumberContainer({super.key, required this.id, required this.date});
  final int id;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBarColor.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.5,
          color: AppColors.primaryColor.withValues(alpha: 0.20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.appBarColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(Assets.imagesTruck),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب رقم $id',
                  style: AppTextStyle.medium16.copyWith(color: Colors.black54),
                ),
                Text(
                  date,
                  style: AppTextStyle.medium16.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
