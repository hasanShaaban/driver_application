import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/OTP/data/models/send_delivery_otp_response_model.dart';
import 'package:driver_application/features/OTP/domain/repo/otp_repo.dart';
import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';

class OtpRepoImpl implements OtpRepo {
  final ApiService apiService;
  final ShipmentLocalDataSource? shipmentLocalDataSource;

  OtpRepoImpl(this.apiService, {this.shipmentLocalDataSource});

  @override
  Future<Either<Failure, SendDeliveryOtpResponseModel>>
  sendDeliveryOtp() async {
    try {
      final response = await apiService.post(
        endPoint: 'driver/shipments/send-delivery-otp',
      );
      final responseModel = SendDeliveryOtpResponseModel.fromJson(
        response.data,
      );
      return right(responseModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SendDeliveryOtpResponseModel>> verifyDeliveryOtp({
    required String otp,
    required int id,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'driver/shipments/complete',
        data: {'shipment_id': id, 'otp': otp},
      );
      final responseModel = SendDeliveryOtpResponseModel.fromJson(
        response.data,
      );
      if (responseModel.data.status == 'delivered') {
        log('---------------------this log to delete the shipment------------');
        await shipmentLocalDataSource?.deleteAcceptedShipment();
      }

      return right(responseModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
