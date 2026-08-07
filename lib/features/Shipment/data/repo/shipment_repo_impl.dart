import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/Shipment/data/models/accept_shipment_response_model.dart';
import 'package:driver_application/features/Shipment/data/models/change_shipment_status_response_model.dart';
import 'package:driver_application/features/Shipment/data/models/route_info.dart';
import 'package:driver_application/features/Shipment/data/models/user_location.dart';
import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';
import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:geolocator/geolocator.dart';

class OrderRepoImpl implements OrderRepo {
  final ApiService apiService;
  final ShipmentLocalDataSource shipmentLocalDataSource;

  OrderRepoImpl({
    required this.apiService,
    required this.shipmentLocalDataSource,
  });

  @override
  Future<Either<Failure, AcceptShipmentResponseModel>> acceptChipment({
    required int shipmentId,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'driver/shipments/accept',
        data: {'shipment_id': shipmentId},
      );
      final responseModel = AcceptShipmentResponseModel.fromJson(response.data);
      await shipmentLocalDataSource.deleteAcceptedShipment();
      await shipmentLocalDataSource.saveAcceptedShipment(
        shipment: responseModel.data,
      );
      return right(responseModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RouteInfo>> getRoute({
    required LatLngPoint start,
    required LatLngPoint end,
  }) async {
    try {
      final json = await apiService.get(
        endPoint:
            'https://maps.googleapis.com/maps/api/directions/json?origin=${start.lat},${start.lng}&destination=${end.lat},${end.lng}&key=AIzaSyDzOsYYDP585Bqp5kQPgKUZ1HVMFGr5H40',
      );
      final route = json.data['routes'][0];
      final leg = route['legs'][0];
      final encodedPolyline = route['overview_polyline']['points'];

      return Right(
        RouteInfo(
          points: _decodePolyline(encodedPolyline),
          distanceMeters: (leg['distance']['value'] as num).toDouble(),
          durationSeconds: (leg['duration']['value'] as num).toDouble(),
        ),
      );
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChangeShipmentStatusResponseModel>> updateTripStatues({
    required int id,
    required String status,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'driver/shipments/update-status',
        data: {'shipment_id': id, 'status': status},
      );
      final responseModel = ChangeShipmentStatusResponseModel.fromJson(
        response.data,
      );
      await shipmentLocalDataSource.deleteAcceptedShipment();
      await shipmentLocalDataSource.saveAcceptedShipment(
        shipment: responseModel.data,
      );
      return right(responseModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateLocation({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await apiService.patch(
        endPoint: 'driver/location',
        data: {'current_lat': lat.toString(), 'current_lon': lng.toString()},
      );
      return right(response.data['status'] == 'success');
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<UserLocation> getCurrentLocation() async {
    await _ensurePermission();

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return UserLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Future<Either<Failure, bool>> cancelShipment({
    required String comment,
    required int id,
  }) async {
    try {
      final response = await apiService.patch(
        endPoint: 'driver/shipments/cancel/$id',
        data: {'reason': comment},
      );
      await shipmentLocalDataSource.deleteAcceptedShipment();
      return right(response.data['status'] == 'success');
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}

Future<void> _ensurePermission() async {
  log('ask for permission');
  LocationPermission permission = await Geolocator.checkPermission();
  log('permission ${permission.index}');

  if (permission == LocationPermission.denied) {
    log('request permission');
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw LocationServiceDisabledException();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw LocationServiceDisabledException();
  }

  if (!await Geolocator.isLocationServiceEnabled()) {
    throw LocationServiceDisabledException();
  }
}

List<LatLngPoint> _decodePolyline(String encoded) {
  List<LatLngPoint> points = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    points.add(LatLngPoint(lat / 1E5, lng / 1E5));
  }
  return points;
}
