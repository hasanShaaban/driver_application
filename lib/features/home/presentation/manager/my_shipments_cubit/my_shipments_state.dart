import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

abstract class MyShipmentsState {}

class MyShipmentsInitial extends MyShipmentsState {}

class MyShipmentsLoading extends MyShipmentsState {}

class MyShipmentsSuccess extends MyShipmentsState {
  final Shipment? shipment;

  MyShipmentsSuccess(this.shipment);
}

class MyShipmentsFailure extends MyShipmentsState {
  final String errMessage;

  MyShipmentsFailure(this.errMessage);
}
