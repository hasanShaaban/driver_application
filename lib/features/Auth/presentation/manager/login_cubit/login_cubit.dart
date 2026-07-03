import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Auth/domain/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

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

    result.fold(
      (failure) {
        emit(LoginFailure(errMessage: failure.message));
      },
      (loginModel) {
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
