import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'package:driver_application/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ShipmentsResponseModel>> getAllShipments({
    required int page,
  }) async {
    try {
      final response = await apiService.get(
        endPoint: 'driver/shipments/available?page=$page',
      );
      return right(ShipmentsResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
