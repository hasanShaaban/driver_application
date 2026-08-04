import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/OTP/data/models/send_delivery_otp_response_model.dart';

abstract class OtpRepo {
  Future<Either<Failure, SendDeliveryOtpResponseModel>> sendDeliveryOtp();
  Future<Either<Failure, SendDeliveryOtpResponseModel>> verifyDeliveryOtp({
    required String otp,
    required int id,
  });
}
