import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'accept_shipment_state.dart';

class AcceptShipmentCubit extends Cubit<AcceptShipmentState> {
  AcceptShipmentCubit(this.orderRepo) : super(AcceptShipmentInitial());

  final OrderRepo orderRepo;

  Future<void> acceptShipment({required int shipmentId}) async {
    emit(AcceptShipmentLoading());
    final result = await orderRepo.acceptChipment(shipmentId: shipmentId);
    result.fold(
      (failure) => emit(AcceptShipmentFailure(failure.message)),
      (responseModel) => emit(AcceptShipmentSuccess(responseModel)),
    );
  }
}
