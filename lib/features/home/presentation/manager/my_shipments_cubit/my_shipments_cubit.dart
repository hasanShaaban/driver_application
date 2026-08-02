import 'package:driver_application/features/home/domain/repo/my_shipments_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_shipments_state.dart';

class MyShipmentsCubit extends Cubit<MyShipmentsState> {
  MyShipmentsCubit(this.myShipmentsRepo) : super(MyShipmentsInitial());

  final MyShipmentsRepo myShipmentsRepo;

  Future<void> fetchSavedShipment() async {
    emit(MyShipmentsLoading());
    try {
      final shipment = await myShipmentsRepo.getSavedShipment();
      emit(MyShipmentsSuccess(shipment));
    } catch (e) {
      emit(MyShipmentsFailure(e.toString()));
    }
  }
}
