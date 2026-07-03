import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, ShipmentsResponseModel>> getAllShipments({
    required int page,
  });
}
