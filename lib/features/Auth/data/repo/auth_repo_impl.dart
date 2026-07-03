import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/Auth/data/models/login_model.dart';
import 'package:driver_application/features/Auth/domain/repo/auth_repo.dart';

import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';

class LoginRepoImpl implements AuthRepo {
  final ApiService apiService;
  final AuthLocalDataSource localDataSource;
  LoginRepoImpl({required this.apiService, required this.localDataSource});
  @override
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'account-center/driver/login',
        data: {'phone_number': phone, 'password': password},
      );
      final loginModel = LoginModel.fromJson(response.data);
      await localDataSource.saveLoginData(loginModel);
      return right(loginModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
