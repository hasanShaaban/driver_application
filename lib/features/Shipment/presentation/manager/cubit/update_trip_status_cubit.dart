import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_trip_status_state.dart';

class UpdateTripStatusCubit extends Cubit<UpdateTripStatusState> {
  UpdateTripStatusCubit(this.orderRepo) : super(UpdateTripStatusInitial());

  final OrderRepo orderRepo;

  Future<void> updateTripStatus({
    required int id,
    required String status,
  }) async {
    emit(UpdateTripStatusLoading());
    final result = await orderRepo.updateTripStatues(id: id, status: status);
    result.fold(
      (failure) => emit(UpdateTripStatusFailure(failure.message)),
      (responseModel) => emit(UpdateTripStatusSuccess(responseModel)),
    );
  }
}
