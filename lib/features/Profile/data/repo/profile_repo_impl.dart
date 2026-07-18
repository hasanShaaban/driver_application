import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:driver_application/features/Profile/data/model/ratings_response_model.dart';
import 'package:driver_application/features/Profile/domain/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;
  final AuthLocalDataSource authLocalDataSource;
  ProfileRepoImpl({
    required this.apiService,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, RatingsResponseModel>> getRatings() async {
    final userModel = authLocalDataSource.getLoginData();
    try {
      final response = await apiService.get(
        endPoint: 'ratings/users/${userModel!.data.uid}/ratings',
      );
      return right(RatingsResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
