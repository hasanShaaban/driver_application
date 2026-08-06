import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/Shipment/data/models/accept_shipment_response_model.dart';
import 'package:driver_application/features/Shipment/data/models/change_shipment_status_response_model.dart';
import 'package:driver_application/features/Shipment/data/models/route_info.dart';
import 'package:driver_application/features/Shipment/data/models/user_location.dart';

abstract class OrderRepo {
  Future<Either<Failure, AcceptShipmentResponseModel>> acceptChipment({
    required int shipmentId,
  });
  Future<Either<Failure, RouteInfo>> getRoute({
    required LatLngPoint start,
    required LatLngPoint end,
  });
  Future<Either<Failure, ChangeShipmentStatusResponseModel>> updateTripStatues({
    required int id,
    required String status,
  });
  Future<Either<Failure, bool>> updateLocation({
    required double lat,
    required double lng,
  });
  Future<UserLocation> getCurrentLocation();
}
