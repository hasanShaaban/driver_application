import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.orderInfo);
        },
        child: Container(
          width: double.infinity,
          height: 160,
          margin: EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFEC400), width: 1.5),
            color: Color(0xFFFBE782).withValues(alpha: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFEDAE10).withValues(alpha: 0.4),
                  ),
                  child: Image(image: AssetImage(Assets.imagesTruck)),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('طلب رقم 501', style: AppTextStyle.medium16),
                            Text(
                              'وقت الطلب 03:15',
                              style: AppTextStyle.medium12.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.seconderyColor.withValues(
                              alpha: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 3,
                          ),
                          child: Text(
                            'بالانتظار',
                            style: AppTextStyle.medium14.copyWith(
                              color: AppColors.seconderyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black87,
                          size: 16,
                        ),
                        Text(
                          '800m (5mins away)',
                          style: AppTextStyle.medium12.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(Assets.iconsSchedule),
                        Text(
                          'تاريخ الطلب :1/1/2026',
                          style: AppTextStyle.medium14.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
