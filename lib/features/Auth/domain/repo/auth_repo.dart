import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/Auth/data/models/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required String password,
  });
}
