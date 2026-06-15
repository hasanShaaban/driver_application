import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/home/presentation/view/widgets/connection_switch.dart';
import 'package:flutter/material.dart';

class HomeHeaderContainer extends StatelessWidget {
  const HomeHeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Color(0xFFF6F6F6),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 19),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'استقبال الطلبات',
                  style: AppTextStyle.bold14.copyWith(color: Colors.black),
                ),
                Text(
                  'ستصلك الطلبات خلال الفترة القادمة',
                  style: AppTextStyle.medium14.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          ConnectionSwitch(),
        ],
      ),
    );
  }
}
