import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/Order/data/models/route_info.dart';
import 'package:driver_application/features/Order/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final ApiService apiService;

  OrderRepoImpl(this.apiService);
  @override
  Future<Either<Failure, bool>> acceptChipment({
    required int shipmentId,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'driver/shipments/accept',
        data: {'shipment_id': shipmentId},
      );
      return right(response.data['status'] == 'success');
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
