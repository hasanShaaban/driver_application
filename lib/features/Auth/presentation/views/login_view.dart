import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/core/utils/widgets/custom_button.dart';
import 'package:driver_application/features/Auth/presentation/views/widget/change_auth_method_section.dart';
import 'package:driver_application/features/Auth/presentation/views/widget/forget_password_section.dart';
import 'package:driver_application/features/Auth/presentation/views/widget/password_text_field.dart';
import 'package:driver_application/features/Auth/presentation/views/widget/phone_text_field.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              Assets.imagesAuthImage,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Text('مرحباً', style: AppTextStyle.bold24),
                    Text(
                      'يرجى إدخال بياناتك قبل الدخول',
                      style: AppTextStyle.regular16.copyWith(
                        color: Color(0xFF807F7F),
                      ),
                    ),
                    SizedBox(height: 27),
                    PhoneTextField(),
                    SizedBox(height: 16),
                    PasswordTextField(),
                    SizedBox(height: 4),
                    ForgetPasswordSection(),
                    SizedBox(height: 33),
                    CustomButton(
                      onTap: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushReplacementNamed(AppRoutes.home);
                      },
                      text: 'تسجيل الدخول',
                    ),
                    SizedBox(height: 140),
                    ChangeAuthMethodSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
