import 'package:driver_application/features/OTP/domain/repo/otp_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_delivery_otp_state.dart';

class SendDeliveryOtpCubit extends Cubit<SendDeliveryOtpState> {
  SendDeliveryOtpCubit(this.otpRepo) : super(SendDeliveryOtpInitial());

  final OtpRepo otpRepo;

  Future<void> sendDeliveryOtp() async {
    emit(SendDeliveryOtpLoading());
    final result = await otpRepo.sendDeliveryOtp();
    result.fold(
      (failure) => emit(SendDeliveryOtpFailure(failure.message)),
      (responseModel) => emit(SendDeliveryOtpSuccess(responseModel)),
    );
  }
}
