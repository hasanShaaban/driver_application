import 'dart:developer';

import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/send_delivery_otp_cubit.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/send_delivery_otp_state.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/verify_delivery_otp_cubit.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/verify_delivery_otp_state.dart';
import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_kit/flutter_otp_kit.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key, this.shipmentId});
  final int? shipmentId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendDeliveryOtpCubit, SendDeliveryOtpState>(
      listener: (context, sendState) {
        if (sendState is SendDeliveryOtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sendState.responseModel.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (sendState is SendDeliveryOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sendState.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, sendState) {
        return BlocConsumer<VerifyDeliveryOtpCubit, VerifyDeliveryOtpState>(
          listener: (context, verifyState) {
            if (verifyState is VerifyDeliveryOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(verifyState.responseModel.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            } else if (verifyState is VerifyDeliveryOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(verifyState.errMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, verifyState) {
            final isLoading =
                sendState is SendDeliveryOtpLoading ||
                verifyState is VerifyDeliveryOtpLoading;

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
                            fieldCount: 6,
                            titleStyle: AppTextStyle.medium24.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            subtitleStyle: AppTextStyle.regular16.copyWith(
                              color: Colors.grey,
                            ),
                            onVerify: (code) async {
                              log(code);
                              int? id = shipmentId;
                              if (id == null) {
                                final savedShipment = await getIt
                                    .get<ShipmentLocalDataSource>()
                                    .getAcceptedShipment();
                                id = savedShipment?.id;
                              }
                              if (id != null && context.mounted) {
                                context
                                    .read<VerifyDeliveryOtpCubit>()
                                    .verifyDeliveryOtp(otp: code, id: id);
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'تعذر العثور على تفاصيل الشحنة',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
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
      },
    );
  }
}
