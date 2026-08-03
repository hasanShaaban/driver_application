import 'package:driver_application/features/OTP/data/models/send_delivery_otp_response_model.dart';

abstract class SendDeliveryOtpState {}

class SendDeliveryOtpInitial extends SendDeliveryOtpState {}

class SendDeliveryOtpLoading extends SendDeliveryOtpState {}

class SendDeliveryOtpSuccess extends SendDeliveryOtpState {
  final SendDeliveryOtpResponseModel responseModel;

  SendDeliveryOtpSuccess(this.responseModel);
}

class SendDeliveryOtpFailure extends SendDeliveryOtpState {
  final String errMessage;

  SendDeliveryOtpFailure(this.errMessage);
}
