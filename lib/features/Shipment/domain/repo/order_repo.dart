import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/Shipment/data/models/accept_shipment_response_model.dart';
import 'package:driver_application/features/Shipment/data/models/route_info.dart';

abstract class OrderRepo {
  Future<Either<Failure, AcceptShipmentResponseModel>> acceptChipment({
    required int shipmentId,
  });
  Future<Either<Failure, RouteInfo>> getRoute({
    required LatLngPoint start,
    required LatLngPoint end,
  });
}
