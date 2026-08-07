import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileResponseModel profileModel;
  ProfileSuccess(this.profileModel);
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  ProfileFailure(this.errorMessage);
}
