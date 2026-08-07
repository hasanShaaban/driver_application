import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';

class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key, required this.profile});

  final ProfileDataModel profile;

  final Map<String, String> genderMapper = const {
    'male': 'ذكر',
    'female': 'أنثى',
  };

  final Map<String, String> vehicleTypeMapper = const {
    'covered': 'مغطاة',
    'open': 'مكشوفة',
    'refrigerated': 'مبرد',
  };

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
              InfoContainer(text: profile.fullName ?? '', title: 'الاسم'),
              InfoContainer(text: profile.phoneNumber ?? '', title: 'الرقم'),
              InfoContainer(
                text: profile.driverProfile?.age?.toString() ?? '',
                title: 'العمر',
                age: profile.driverProfile?.age,
              ),
              InfoContainer(
                text: genderMapper[profile.driverProfile?.gender] ?? '',
                title: 'الجنس',
              ),
              InfoContainer(
                text: profile.driverProfile?.id?.toString() ?? '',
                title: 'رقم الهوية',
              ),
              InfoContainer(
                text: profile.driverProfile?.licensePlateNumber ?? '',
                title: 'رقم السيارة',
              ),
              InfoContainer(
                text:
                    vehicleTypeMapper[profile.driverProfile?.vehicleType] ?? '',
                title: 'نوع المركبة',
              ), // Replaced 'رقم الرخصة' since it's not in model
              InfoContainer(
                text: double.parse(
                  profile.driverProfile?.ratingInfo?.averageRating ?? '',
                ).floorToDouble().toString(),
                title: 'التقييم',
              ),
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
              // if (age != null) Text('$age Years'),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
