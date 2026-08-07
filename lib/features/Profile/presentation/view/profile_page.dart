import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_container.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_curved_header.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_image_section.dart';
import 'package:driver_application/features/Profile/presentation/view/widgets/profile_rows.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:driver_application/features/Profile/presentation/manager/profile_cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileCurvedHeader(),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              String? imageUrl;
              String name = 'Laiba Ahmar';
              String emailPhone = 'youremail@domain.com | +01 234 567 89';

              if (state is ProfileSuccess) {
                final profile = state.profileModel.data;
                imageUrl = profile?.profilePictureUrl;
                name = profile?.fullName ?? name;
                emailPhone = '${profile?.email ?? "youremail@domain.com"} | ${profile?.phoneNumber ?? "+01 234 567 89"}';
              }

              return Column(
                children: [
                  ProfileImageSection(imageUrl: imageUrl),
                  SizedBox(height: 5),
                  if (state is ProfileLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: CircularProgressIndicator(),
                    ),
                  if (state is ProfileFailure)
                    Text('Failed to load profile', style: TextStyle(color: Colors.red)),
                  Text(
                    name,
                    style: AppTextStyle.semiBold22.copyWith(color: Colors.black),
                  ),
                  Text(
                    emailPhone,
                    style: AppTextStyle.regular15.copyWith(color: Colors.black),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ProfileContainer(
                  content: [
                    NonFunctionalProfileRow(
                      onTap: () {
                        final state = context.read<ProfileCubit>().state;
                        if (state is ProfileSuccess && state.profileModel.data != null) {
                          Navigator.pushNamed(
                            context, 
                            AppRoutes.profileInfo, 
                            arguments: state.profileModel.data,
                          );
                        } else {
                          // Optionally show a snackbar if data is not loaded yet
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('جاري تحميل البيانات، يرجى الانتظار')),
                          );
                        }
                      },
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
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profits);
                      },
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
