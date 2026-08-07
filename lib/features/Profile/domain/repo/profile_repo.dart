import 'package:dartz/dartz.dart';
import 'package:driver_application/core/errors/failures.dart';
import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';
import 'package:driver_application/features/Profile/data/model/profits_response_model.dart';
import 'package:driver_application/features/Profile/data/model/ratings_response_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, RatingsResponseModel>> getRatings();
  Future<Either<Failure, ProfileResponseModel>> getProfile();
  Future<Either<Failure, ProfitsResponseModel>> getProfits();
}
