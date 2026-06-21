import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfitsView extends StatelessWidget {
  const ProfitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأرباح', style: AppTextStyle.medium18),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.successColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'عميل رقم 10',
                                style: AppTextStyle.bold15.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '50 ريال',
                                style: AppTextStyle.bold15.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'رقم العميل: 154666665',
                            style: AppTextStyle.medium12,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '15 فبراير , 12:30 م',
                                style: AppTextStyle.medium12,
                              ),
                              Spacer(),
                              Text(
                                'ناجح',
                                style: AppTextStyle.bold15.copyWith(
                                  color: AppColors.successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
