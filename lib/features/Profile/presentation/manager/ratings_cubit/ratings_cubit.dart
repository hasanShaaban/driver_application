import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Profile/domain/repo/profile_repo.dart';
import 'package:driver_application/features/Profile/presentation/manager/ratings_cubit/ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  final ProfileRepo profileRepo;

  RatingsCubit(this.profileRepo) : super(RatingsInitial());

  Future<void> fetchRatings() async {
    emit(RatingsLoading());
    final result = await profileRepo.getRatings();
    result.fold(
      (failure) => emit(RatingsFailure(failure.message)),
      (ratingsResponse) => emit(RatingsSuccess(ratingsResponse)),
    );
  }
}
