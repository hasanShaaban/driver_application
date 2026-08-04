import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';

abstract class NotificationRepo {
  Future<Either<Failure, String>> getFcmToken();
  Future<Either<Failure, bool>> updateFirebaseToken(String token);
  Future<Either<Failure, bool>> fetchAndSendFcmToken();
}
