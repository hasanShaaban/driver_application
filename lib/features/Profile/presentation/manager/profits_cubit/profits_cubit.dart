import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Profile/domain/repo/profile_repo.dart';
import 'profits_state.dart';

class ProfitsCubit extends Cubit<ProfitsState> {
  final ProfileRepo profileRepo;

  ProfitsCubit(this.profileRepo) : super(ProfitsInitial());

  Future<void> fetchProfits() async {
    emit(ProfitsLoading());
    final result = await profileRepo.getProfits();
    result.fold(
      (failure) => emit(ProfitsFailure(failure.message)),
      (profitsModel) => emit(ProfitsSuccess(profitsModel)),
    );
  }
}
