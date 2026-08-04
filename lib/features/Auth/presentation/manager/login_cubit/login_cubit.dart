import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/core/notifications/repo/notification_repo.dart';
import 'package:driver_application/features/Auth/domain/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final NotificationRepo notificationRepo;

  LoginCubit(this.authRepo, this.notificationRepo) : super(LoginInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (phoneController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      emit(LoginFailure(errMessage: 'يرجى إدخال رقم الهاتف وكلمة المرور'));
      return;
    }

    if (passwordController.text.trim().length < 8) {
      emit(LoginFailure(errMessage: 'يجب أن تكون كلمة المرور أكثر من 8 أحرف'));
      return;
    }

    emit(LoginLoading());

    var result = await authRepo.login(
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    await result.fold(
      (failure) async {
        emit(LoginFailure(errMessage: failure.message));
      },
      (loginModel) async {
        await notificationRepo.fetchAndSendFcmToken();
        emit(LoginSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
