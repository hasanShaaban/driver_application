import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Profile/domain/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> fetchProfileData() async {
    emit(ProfileLoading());
    final result = await profileRepo.getProfile();
    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (profileModel) => emit(ProfileSuccess(profileModel)),
    );
  }
}
