import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معلوماتي', style: AppTextStyle.medium18),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30),
              InfoContainer(text: 'أحمد النجار', title: 'الاسم'),
              InfoContainer(text: '099898765456', title: 'الرقم'),
              InfoContainer(text: '8/8/1995', title: 'العمر', age: 32),
              InfoContainer(text: 'ذكر', title: 'الجنس'),
              InfoContainer(text: '0108843234567888', title: 'رقم الهوية'),
              InfoContainer(text: '0778891', title: 'رقم السيارة'),
              InfoContainer(text: '099863552', title: 'رقم الرخصة'),
              InfoContainer(text: '4.5', title: 'التقييم'),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.title,
    required this.text,
    this.age,
  });
  final String title;
  final String text;
  final int? age;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.medium14.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: AppTextStyle.medium16),
              if (age != null) Text('$age Years'),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
