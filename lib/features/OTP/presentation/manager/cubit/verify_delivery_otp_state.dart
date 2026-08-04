import 'package:driver_application/features/OTP/data/models/send_delivery_otp_response_model.dart';

abstract class VerifyDeliveryOtpState {}

class VerifyDeliveryOtpInitial extends VerifyDeliveryOtpState {}

class VerifyDeliveryOtpLoading extends VerifyDeliveryOtpState {}

class VerifyDeliveryOtpSuccess extends VerifyDeliveryOtpState {
  final SendDeliveryOtpResponseModel responseModel;

  VerifyDeliveryOtpSuccess(this.responseModel);
}

class VerifyDeliveryOtpFailure extends VerifyDeliveryOtpState {
  final String errMessage;

  VerifyDeliveryOtpFailure(this.errMessage);
}
