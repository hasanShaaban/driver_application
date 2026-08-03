import 'dart:developer';

import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/send_delivery_otp_cubit.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/send_delivery_otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_kit/flutter_otp_kit.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendDeliveryOtpCubit, SendDeliveryOtpState>(
      listener: (context, state) {
        if (state is SendDeliveryOtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.responseModel.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is SendDeliveryOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SendDeliveryOtpLoading;

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      OtpKit(
                        title: 'رمز تحقق',
                        subtitle:
                            'الرجاء ادخال الكود الذي تم ارساله \n الى هاتف المستلم*******09',
                        fieldCount: 5,
                        titleStyle: AppTextStyle.medium24.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        subtitleStyle: AppTextStyle.regular16.copyWith(
                          color: Colors.grey,
                        ),
                        onVerify: (code) async {
                          log(code);
                          return true;
                        },
                        textDirection: TextDirection.ltr,
                        buttonText: 'إرسال',
                        resendText: 'إعادة ارسال',
                        resendStyle: AppTextStyle.medium16.copyWith(
                          color: AppColors.seconderyColor,
                        ),
                        buttonBackgroundColor: AppColors.primaryColor,
                        buttonBorderRadius: 8,
                        onResend: () {
                          context
                              .read<SendDeliveryOtpCubit>()
                              .sendDeliveryOtp();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
