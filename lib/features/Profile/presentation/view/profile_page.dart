import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_container.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_curved_header.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_image_section.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_rows.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileCurvedHeader(),
          ProfileImageSection(),
          SizedBox(height: 5),
          Text(
            'Laiba Ahmar',
            style: AppTextStyle.semiBold22.copyWith(color: Colors.black),
          ),
          Text(
            'youremail@domain.com | +01 234 567 89',
            style: AppTextStyle.regular15.copyWith(color: Colors.black),
          ),
          SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ProfileContainer(
                  content: [
                    NonFunctionalProfileRow(
                      onTap: () {},
                      text: 'معلومات شخصية',
                      icon: Assets.iconsProfileInfo,
                    ),
                    FunctionalProfileRow(
                      textButton: 'تغعيل',
                      text: 'الاشعارات',
                      icon: Assets.iconsProfileNotifications,
                      onTap: () {},
                    ),
                    FunctionalProfileRow(
                      textButton: 'العربية',
                      icon: Assets.iconsLanguage,
                      onTap: () {},
                      text: 'اللغة',
                    ),
                  ],
                ),
                SizedBox(height: 17),
                ProfileContainer(
                  content: [
                    NonFunctionalProfileRow(
                      onTap: () {},
                      text: 'الأرباح',
                      icon: Assets.iconsProfits,
                    ),
                    NonFunctionalProfileRow(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myRate);
                      },
                      text: 'تقييماتي',
                      icon: Assets.iconsStar,
                    ),
                  ],
                ),
                SizedBox(height: 17),
                ProfileContainer(
                  content: [
                    NonFunctionalProfileRow(
                      onTap: () {},
                      text: 'Help & Support',
                      icon: Assets.iconsHelpSupport,
                    ),
                    NonFunctionalProfileRow(
                      onTap: () {},
                      text: 'Contact us',
                      icon: Assets.iconsContactUs,
                    ),
                    NonFunctionalProfileRow(
                      onTap: () {},
                      text: 'Privacy policy',
                      icon: Assets.iconsPrivacy,
                    ),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
