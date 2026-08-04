import 'package:driver_application/features/OTP/domain/repo/otp_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_delivery_otp_state.dart';

class VerifyDeliveryOtpCubit extends Cubit<VerifyDeliveryOtpState> {
  VerifyDeliveryOtpCubit(this.otpRepo) : super(VerifyDeliveryOtpInitial());

  final OtpRepo otpRepo;

  Future<void> verifyDeliveryOtp({
    required String otp,
    required int id,
  }) async {
    emit(VerifyDeliveryOtpLoading());
    final result = await otpRepo.verifyDeliveryOtp(otp: otp, id: id);
    result.fold(
      (failure) => emit(VerifyDeliveryOtpFailure(failure.message)),
      (responseModel) => emit(VerifyDeliveryOtpSuccess(responseModel)),
    );
  }
}
