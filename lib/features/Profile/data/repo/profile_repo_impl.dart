import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';
import 'package:driver_application/features/Profile/data/model/ratings_response_model.dart';
import 'package:driver_application/features/Profile/domain/repo/profile_repo.dart';
import 'package:driver_application/features/Profile/domain/data_source/profile_local_data_source.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;
  final AuthLocalDataSource authLocalDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRepoImpl({
    required this.apiService,
    required this.authLocalDataSource,
    required this.profileLocalDataSource,
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

  @override
  Future<Either<Failure, ProfileResponseModel>> getProfile() async {
    try {
      int count = profileLocalDataSource.getProfileVisitCount();
      count++;
      log('count is :$count');
      await profileLocalDataSource.saveProfileVisitCount(count);

      final localProfile = profileLocalDataSource.getProfileData();

      // Fetch every 5 times or if local data is missing
      if (count % 5 == 1 || localProfile == null) {
        log('fetching data from server');
        final reponse = await apiService.get(endPoint: 'me');
        final profileModel = ProfileResponseModel.fromJson(reponse.data);
        await profileLocalDataSource.saveProfileData(profileModel);
        return right(profileModel);
      } else {
        log('fetching data from local');
        return right(localProfile);
      }
    } on DioException catch (e) {
      // If network fails but we have local data, we could return it
      final localProfile = profileLocalDataSource.getProfileData();
      if (localProfile != null) {
        return right(localProfile);
      }
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      final localProfile = profileLocalDataSource.getProfileData();
      if (localProfile != null) {
        return right(localProfile);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
