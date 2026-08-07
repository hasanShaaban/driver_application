import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cancel_shipment_state.dart';

class CancelShipmentCubit extends Cubit<CancelShipmentState> {
  CancelShipmentCubit(this.orderRepo) : super(CancelShipmentInitial());

  final OrderRepo orderRepo;

  Future<void> cancelShipment({
    required int id,
    required String comment,
  }) async {
    emit(CancelShipmentLoading());
    final result = await orderRepo.cancelShipment(id: id, comment: comment);
    result.fold(
      (failure) => emit(CancelShipmentFailure(failure.message)),
      (_) => emit(CancelShipmentSuccess()),
    );
  }
}
