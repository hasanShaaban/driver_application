import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyRateView extends StatelessWidget {
  const MyRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'تقييماتي',
          style: AppTextStyle.medium18.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(Assets.iconsFilledStar),
                Text(
                  '4.5',
                  style: AppTextStyle.bold20.copyWith(color: Colors.black),
                ),
              ],
            ),
            Text(
              '20 تقييم',
              style: AppTextStyle.medium14.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 47),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'عمر اسامة منذ 3 أيام',
                              style: AppTextStyle.medium14,
                            ),
                            SizedBox(width: 4),
                            ...List.generate(5, (index) {
                              return Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.iconsFilledStar,
                                    width: 14,
                                  ),
                                  SizedBox(width: 4),
                                ],
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text('تم تقييمك ب 4.3 من قبل أحد العملاء!'),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 20,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
