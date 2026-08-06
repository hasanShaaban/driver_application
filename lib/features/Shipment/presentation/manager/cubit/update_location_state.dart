abstract class UpdateLocationState {}

class UpdateLocationInitial extends UpdateLocationState {}

class UpdateLocationLoading extends UpdateLocationState {}

class UpdateLocationSuccess extends UpdateLocationState {
  final bool success;

  UpdateLocationSuccess(this.success);
}

class UpdateLocationFailure extends UpdateLocationState {
  final String errMessage;

  UpdateLocationFailure(this.errMessage);
}
