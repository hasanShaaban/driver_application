import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/core/notifications/repo/notification_repo.dart';
import 'package:driver_application/core/notifications/services/push_notification_service.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;
  final PushNotificationService pushNotificationService;

  NotificationRepoImpl(this.apiService, this.pushNotificationService);

  @override
  Future<Either<Failure, String>> getFcmToken() async {
    try {
      final token = await pushNotificationService.getToken();
      log(
        '-------------------------------FCM Token : $token ------------------------------------',
      );
      if (token != null && token.isNotEmpty) {
        return right(token);
      } else {
        return left(ServerFailure('FCM Token is null or empty'));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateFirebaseToken(String token) async {
    try {
      final response = await apiService.patch(
        endPoint: 'account-center/fcm-token',
        data: {'fcm_token': token},
      );
      bool result = response.data['status'] == 'success' ? true : false;
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> fetchAndSendFcmToken() async {
    final tokenResult = await getFcmToken();
    return tokenResult.fold(
      (failure) => left(failure),
      (token) => updateFirebaseToken(token),
    );
  }
}
