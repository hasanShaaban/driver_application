import 'package:driver_application/features/Profile/data/model/ratings_response_model.dart';

abstract class RatingsState {}

class RatingsInitial extends RatingsState {}

class RatingsLoading extends RatingsState {}

class RatingsSuccess extends RatingsState {
  final RatingsResponseModel ratingsResponse;

  RatingsSuccess(this.ratingsResponse);
}

class RatingsFailure extends RatingsState {
  final String errMessage;

  RatingsFailure(this.errMessage);
}
